Return-Path: <linux-fsdevel+bounces-444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C67CB15A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08D4B20ED0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FE31A92;
	Mon, 16 Oct 2023 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1zCkWf6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45733158F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 17:30:56 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50146A7;
	Mon, 16 Oct 2023 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yLqLiO937F4b67IKVnxwlg7DScyO6XZyFuWgKPb++No=; b=L1zCkWf6sNpT4565aixenhdGzR
	DJ47v2X4sBmxJbecCe3NUKOhIUzK0Si5HChZCsFnKqdAnVlwGMP7X1pSG+gvuG2rG7GGrPYpeOqf8
	l0J7ExE2vIDMc2A+p3JTK6Qwcu2sZN+lNB/MyNqg7RjBaik+S7XUT9gPVA46uclofeXWPU109y2Xs
	eTABCOwFjsEe4+MOdk4YiF2j7UQYtih2hRWh/4hS5BFFje0KFHYSN9+4ilxnP/6zdl8LD/G+PeiM3
	QeW+uUzICWEHeWXUyPP47eaZdg6CeP2/2cZbpCc662thbzWxh3J7dI8MRlYtrhB5ATDzanIkAwXB6
	gJ+UWNEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsRQY-007NmB-Gn; Mon, 16 Oct 2023 17:30:50 +0000
Date: Mon, 16 Oct 2023 18:30:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>,
	samba-technical <samba-technical@lists.samba.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH][SMB3 client] fix touch -h of symlink
Message-ID: <ZS1zSoRwv+yr5BHS@casper.infradead.org>
References: <CAH2r5mui-uk5XVnJMM2UQ40VJM5dyA=+YChGpDcLAapBTCk4kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mui-uk5XVnJMM2UQ40VJM5dyA=+YChGpDcLAapBTCk4kw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 12:26:23PM -0500, Steve French wrote:
> For example:
>           touch -h -t 02011200 testfile
>     where testfile is a symlink would not change the timestamp, but
>           touch -t 02011200 testfile
>     does work to change the timestamp of the target
> 
> Looks like some symlink inode operations are missing for other fs as well

Do we have an xfstests for this?


