Return-Path: <linux-fsdevel+bounces-4450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB67FF9F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37591C20C87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E265A0F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWmkzBCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB254FBA;
	Thu, 30 Nov 2023 16:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E27C433C7;
	Thu, 30 Nov 2023 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701362621;
	bh=Y4sgZDhs4wynPu47QMjQjQHfSY0fT9c/kB/u77jBAg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWmkzBCcc03gYkV1g/4ZMIMtNwjz8M8v20ER1M80R/lbHM3FMU6q/uOuSCweHsyCt
	 i9B1Q5/QsNYeJEm50I/mcZO8F6+dURkViHUWGV99uMg/lzVCpGdYXAonMMvirJeOeX
	 PzHwSe+jzSNwLF02Qc6OgwFWGE2WbHgBm3IC+S+nauyTpZORqTYW5mn89ikFgZOSJY
	 6/joQKMbn3Mc7+WBZ9v+be2BEsyDQmS0IxOiVoDg8jNyMaOmNZZfbel6yVXtExBvLl
	 rswEj7+T8NbulbipMkNtf0n1Kk98brwqIXbz6sFbEHoXmFyU5WfkyqwtXXGw72IlZ5
	 rj/aFVcvYlO2A==
Date: Thu, 30 Nov 2023 10:43:40 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 12/16] ovl: use vfs_{get,set}_fscaps() for copy-up
Message-ID: <ZWi7vATF7xIKxlsr@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-12-da5a26058a5b@kernel.org>
 <CAOQ4uxj=oR+yj19rUm0E6cHTiStniqvebtZSDhV3XZC1qz6n6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj=oR+yj19rUm0E6cHTiStniqvebtZSDhV3XZC1qz6n6A@mail.gmail.com>

On Thu, Nov 30, 2023 at 08:23:28AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:50 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Using vfs_{get,set}xattr() for fscaps will be blocked in a future
> > commit, so convert ovl to use the new interfaces. Also remove the now
> > unused ovl_getxattr_value().
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> 
> You may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks!

> I am assuming that this work is destined to be merged via the vfs tree?
> Note that there is already a (non-conflicting) patch to copy_up.c on
> Christian's vfs.rw branch.

I'll leave that up to Christian. There are also other mnt_idmapping.h
changes on vfs.misc which could cause (probably minor) conflicts.

