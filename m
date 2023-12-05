Return-Path: <linux-fsdevel+bounces-4908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906DB8061EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448B71F21209
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EE3FE37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v/olVTT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D24196;
	Tue,  5 Dec 2023 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=PaxZkLLx0jxzIbcOPDTCZy8j45AuGDflCXboembxXDQ=; b=v/olVTT4L++PZOFWqMtE88KMip
	2EqgzAkRcEL4VV0Xh9PDEdLyq19Uc4IeTpFgOdwceLpfv0J7hJhUZf8hQYU4Cu2mHvMH38WXBef0+
	h4F2/MkMhCCiXIX94WdZFIBX/rtwuyiWDtq7GJL7B7JuhaoM2pr8s+O6JGPqmY9OPd+RkTQK/IbSn
	luWLVLten9V9arZv5euLBno80sx9FJVnXohP8nmgl/n2sAWwc1+p6GHSp1Lbr2isSotmUDC9TnPr9
	wxUF1Qx5x/yGum6b9RqP1BowU1SS+fli2TAMT6CJR1qkcKS4LPJijqSt+P4lrgHjwRIiQDfOA3JYB
	GExdSYMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAdz1-008WZd-01;
	Tue, 05 Dec 2023 22:33:39 +0000
Date: Tue, 5 Dec 2023 14:33:38 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Weißschuh wrote:
> @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
>  		return -EROFS;
>  
>  	/* Am I creating a permanently empty directory? */
> -	if (sysctl_is_perm_empty_ctl_header(header)) {
> +	if (header->ctl_table == sysctl_mount_point ||
> +	    sysctl_is_perm_empty_ctl_header(header)) {
>  		if (!RB_EMPTY_ROOT(&dir->root))
>  			return -EINVAL;
>  		sysctl_set_perm_empty_ctl_header(dir_h);

While you're at it.

This just made me cringe, and curious if some other changes
could be done to make this obviously clear during patch review
that this is safe.

  Luis

