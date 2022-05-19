Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B152D39D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiESNJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 09:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiESNJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 09:09:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8809BCE88;
        Thu, 19 May 2022 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vUv8v61VHIxh8esWamo0UaDA5N+0XE9YmKiSe8EzIBI=; b=V2Fl3DlO7O+BQYAReJ1eydhaQX
        OE3S7WTEY2Qzsd0CCiqASt2DNhWsiYn3JSj27dYyFgp1En5pWHKV3jxjnc7y6Pl4jEPpChLx5s3in
        lf6oKRoy4hMI3Y1waomzUbgWqbZrzDMj9nZ+HeMRIpleGjCPo3Jvo73q4Qkb8PJjdRyVbQFecCxHq
        vFNthfMQvap+t+zNwI0XLnVnZSjeynAVR1V5y0j4DAOsBGQKMcMxTsBMF5QmyjMwzy5Wj81Hmo6xJ
        PFZxOqF1zUYeP/7/KA4ZuCnkw1Tp0huv4AXmrvF0cLYLL2DzmiMnrEC+Dw6Zl+L5ibdoQwY8erRTz
        D1p71MAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrftl-00Ck60-Qd; Thu, 19 May 2022 13:09:01 +0000
Date:   Thu, 19 May 2022 14:09:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] sysctl: handle table->maxlen properly for proc_dobool
Message-ID: <YoZBbcEHcLqsAssF@casper.infradead.org>
References: <20220519125505.92400-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519125505.92400-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 08:55:05PM +0800, Muchun Song wrote:
> @@ -428,6 +428,8 @@ static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
>  				int write, void *data)
>  {
>  	if (write) {
> +		if (*negp || (*lvalp != 0 && *lvalp != 1))
> +			return -EINVAL;
>  		*(bool *)valp = *lvalp;
>  	} else {
>  		int val = *(bool *)valp;

Is this the right approach?  Or should we do as C does and interpret
writing non-zero as true?  ie:

		*(bool *)valp = (bool)*lvalp;

(is that cast needed?  It wouldn't be if it were an int, but bool is a
bit weird)

