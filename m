Return-Path: <linux-fsdevel+bounces-3130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D17F03A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 00:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88900280E52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76B20337;
	Sat, 18 Nov 2023 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VNNzvhC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE01BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 15:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p03pvU/XpM4YJ6OSu7IAy6nmhcSG/+SnmKCVHjdFI+8=; b=VNNzvhC78vvZzWVt1m2sxCtwo5
	2mOZp7gjwY13FZYYAtFXUDOLk9NBER/BDK+LLztvkrsdPKHzzQZ357L6kUMXRfjDSxZCVs98FkhRl
	MGt0QAkO5koP4Zp5VzePhHDNaEi88HXEtEzPCMSmR0AQExxSF6VWlqe/vsiuT5itWpYgGydjtna1v
	RfEOLZFiBC/eXDKET/ujkPnryKLAD2Mi1O2DDGodSawMNWZdh2Ew5QJRmdxMsUQq5aAO+1qM5lLAx
	zvBY/WYt3gpAEgwnlhPrph3x64GeDScwWU0FRdjXVs0upuE4OdIyzJzaI6/WISsyDQmmN8nzM/iTS
	4aRNaI7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r4UrS-0002Ba-2q;
	Sat, 18 Nov 2023 23:36:26 +0000
Date: Sat, 18 Nov 2023 23:36:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, akpm@linux-foundation.org,
	brauner@kernel.org, hughd@google.com, jlayton@redhat.com,
	Tavian Barnes <tavianator@tavianator.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231118233626.GH1957730@ZenIV>
References: <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
 <ZVk2m1scRfy4Xq0C@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVk2m1scRfy4Xq0C@tissot.1015granger.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 18, 2023 at 05:11:39PM -0500, Chuck Lever wrote:

> We don't hold f_pos_lock in offset_dir_llseek(), though.

We'd better...  Which call chain leads to it without ->f_pos_lock?

