Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9274C3D9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjGILlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGILlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:41:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF6DBA;
        Sun,  9 Jul 2023 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fIXPzfpDnl12CuFsfRY5j0Rj2DrqlsOG4+dLIdpRFxg=; b=OzogSOZmCXUCp5ZR5+BkWIiuEP
        3fX9JvHGZFWBonRWhfURn/l5iVc+fu65rMnzGKZLfKXxhzyrDOK4UNs8J3IBdFiJTk93XNtWZIOa2
        1j+Yil5vsY33aAAeQkyxTaQNpHjffygqcQU9MkbRi10DjVvzSrvFDKyF1AMVDEn9Uj5Aa8IAs7oR/
        OAAvAG8cFCx+2olFtU7YtchRDAKErstNtwNeYX9KZibU2ic0Wd0jsqHxFjijPuZGvPYeDsck2mjp2
        Aanp37zSKKs7Ra3sgxYsz//cEL3/TNF2CXBk1P0SKPtMiLXTNRk0xH+RSMObabF1PfHqE/OR3jcr7
        n9KmMirg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qISn7-00DhEf-Ue; Sun, 09 Jul 2023 11:41:25 +0000
Date:   Sun, 9 Jul 2023 12:41:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linke Li <lilinke99@foxmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH] isofs: fix undefined behavior in iso_date()
Message-ID: <ZKqc5Uj14C7ST21K@casper.infradead.org>
References: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 09, 2023 at 02:42:55PM +0800, Linke Li wrote:
> From: Linke Li <lilinke99@gmail.com>
> 
> Fix undefined behavior in the code by properly handling the left shift operaion.
> Instead of left-shifting a negative value, explicitly cast -1 to an unsigned int
> before the shift. This ensures well defined behavior and resolves any potential
> issues.

This certainly fixes the problem, but wouldn't it be easier to get the
compiler to do the work for us?

#include <stdio.h>

int f(unsigned char *p)
{
	return (signed char)p[0];
}

int main(void)
{
	unsigned char x = 0xa5;

	printf("%d\n", f(&x));

	return 0;
}

prints -91.
