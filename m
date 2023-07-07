Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3674B5DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGGRbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGGRbE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:31:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0DD1BD2
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QLw4OXVx5tZdsXExTE106w94c8KQTJn96sQcUwp8c0c=; b=hiQezpd2lTB9s0eE3hpARueuI0
        qucvkLV/luZ5wAvyfI8zqa7UU+zHxwPqddlf9BKxpbS5/jo/nSRBg2u5go82hTaidWfwQcCC3xrRp
        s4454vbJB6svQdnbcVS7bU5FCM4PpxPmaTRY7jNg3VIf6418c+qutRJgCR8Ziy0NJHD6j7HnhrOTx
        wQdKrBb3A0Ofe13BMg5gI/kKhzmwInXJC/deH/ijQt3beJuqbudWbraDhwTuI/9ueZJ7O1n5ZeR/7
        pRH5B4We6L/GwQId+WUgKpuSmxg+yfC8ZW9yW387yA4Gmk0O29xGeFJNy/gA7KDLBd+XVlUZPou8p
        uMKsRrCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHpIL-00CDYy-UC; Fri, 07 Jul 2023 17:31:01 +0000
Date:   Fri, 7 Jul 2023 18:31:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Roi L <roeilev321_@outlook.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [char_dev] Invalid uses of cdev_add return value
Message-ID: <ZKhL1Y6jyjcefGAf@casper.infradead.org>
References: <PH0P220MB0460FF96CAD7BE766E439DE8DD2DA@PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0P220MB0460FF96CAD7BE766E439DE8DD2DA@PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:55:28PM +0300, Roi L wrote:
> I hope I'm emailing the right place. I have recently noticed that there
> are many invalid uses of `cdev_add`'s return value in the kernel source.
> While `cdev_add` clearly mentions that it returns a negative value on
> failure, many calls to this function check the return value as a
> positive value.
> 
> E.g. (/drivers/mtd/ubi/vmt.c:581)
> ```
> err = cdev_add(&vol->cdev, dev, 1);
> if (err) {
> 	ubi_err(ubi, "cannot add character device for volume %d, error %d",
> 		vol_id, err);

OK, what you're missing is that on success, cdev_add() returns zero.
So in practice, there is no difference between 'if (err)' and
'if (err < 0)'.  Both check for an error, as err can never be positive.

I happen to think it's good practice to check for err < 0 rather than
just err, and it makes no difference at all on any CPU that I've ever
encountered.  But patches to clean it up would be unwelcome churn.

Thanks for checking rather than starting out by sending patches that
would have to be rejected!
