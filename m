Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214D17718BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 05:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHGDSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 23:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHGDSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:18:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4E10F7;
        Sun,  6 Aug 2023 20:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YLGI+m+NtSfah82olnSRoKFqUzieef4s4ojluCMDHpQ=; b=avi5+BV2nn4+9w0hK9/NTCHS9f
        fHFDN2iP+4ajHibTF3ytnoRejVZvJuizuiWN3+ZJw7aKfMR7FRQAl2r1s7fELP0EC39pnh39Kveu1
        VOwEg6QBl3iXnaMHMiS9RYcmxUKXiOf9FgdLxGP5Y9m5cEKVdqesePOkhfUOa+tFJQoitydRmNsWr
        TIGXzMYjGsoEqejJgOqI8ovxWuTEkN74sBZqkezFzAX1wjZXHCyjPuf+1PDmxZXGknOoqFdCnLJNl
        HiGGROamZfkEYwUE7CgVkzADgahTorf8aAzHWrOhVCn77xvtQiiZQZTIuQ3lYW83TvOv1BTH+LtNl
        ttBAmL+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSqlS-00828U-Qi; Mon, 07 Aug 2023 03:18:38 +0000
Date:   Mon, 7 Aug 2023 04:18:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
Message-ID: <ZNBijjmst12/V87J@casper.infradead.org>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806230627.1394689-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:06:27AM +0200, Mateusz Guzik wrote:
> With the assumption this is not going to work, I wrote my own patch
> which adds close_fd_sync() and filp_close_sync().  They are shipped as
> dedicated func entry points, but perhaps inlines which internally add a
> flag to to the underlying routine would be preferred?

Yes, I think static inlines would be better here.  

> Also adding __ in
> front would be in line with __fput_sync, but having __filp_close_sync
> call  __filp_close looks weird to me.

I'd handle this as ...

int file_close_sync(struct file *, fl_owner_t, bool sync);
static inline filp_close(struct file *file, fl_owner_t owner)
{
	return file_close_sync(file, owner, false);
}

