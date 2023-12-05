Return-Path: <linux-fsdevel+bounces-4859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9037805062
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2891C20D83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382355C04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m36ly+os"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641913C082;
	Tue,  5 Dec 2023 09:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2024C433C8;
	Tue,  5 Dec 2023 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701767630;
	bh=eJuwNnWu6g9nwVGxomFxgvI4Y9eQAK/z4W+ooWCv1FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m36ly+ost0Hm+D/k5ncdMp8hmQgNKenkoAe71TF6RTqgotjTcUC5UzKJXJeZL3Ax0
	 gpVQIbuRYeoZadwQlhqTJrH5gg3k++yN2ywrfF5nCx0CoGWHXG8jKbyf5XIbsAT5Zx
	 7Ql3YmJDP0CVimx4ekDg6+9eFXLkdhRXKUADGe31bBi2JGsMu4MW/eYQWM2oax5nvA
	 Yf722/uyY0IXfaL4jk7x3HmqUET3+0hzxdfuUtTe6MKuEflBJeDoQRQCMkVGnfpUxH
	 h6qJpM90+KYs5saftdxzo8mwZk/4QW7nXl5kPjeSyvXBH5tj0TiDlRIigkBDkZEbWf
	 ZeoVpSURE7zXA==
Date: Tue, 5 Dec 2023 09:13:44 +0000
From: Simon Horman <horms@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v11 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
Message-ID: <20231205091344.GR50400@kernel.org>
References: <20231127190409.2344550-1-andrii@kernel.org>
 <20231127190409.2344550-3-andrii@kernel.org>
 <20231130163655.GC32077@kernel.org>
 <CAEf4BzZ0JWFrS_DLk_YOGNqyh39kqFcCNbd_D6mCM6d0mzxO_Q@mail.gmail.com>
 <CAEf4BzbN2xovoTyQeK1sHZdB-YMeiC=U7oOmUcpcb5_ZHEcFgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbN2xovoTyQeK1sHZdB-YMeiC=U7oOmUcpcb5_ZHEcFgA@mail.gmail.com>

On Thu, Nov 30, 2023 at 10:13:41AM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 30, 2023 at 10:03 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Nov 30, 2023 at 8:37 AM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Mon, Nov 27, 2023 at 11:03:54AM -0800, Andrii Nakryiko wrote:
> > >
> > > ...
> > >
> > > > @@ -764,7 +817,10 @@ static int bpf_get_tree(struct fs_context *fc)
> > > >
> > > >  static void bpf_free_fc(struct fs_context *fc)
> > > >  {
> > > > -     kfree(fc->fs_private);
> > > > +     struct bpf_mount_opts *opts = fc->s_fs_info;
> > > > +
> > > > +     if (opts)
> > > > +             kfree(opts);
> > > >  }
> > >
> > > Hi Andrii,
> > >
> > > as it looks like there will be a v12, I have a minor nit to report: There
> > > is no need to check if opts is non-NULL because kfree() is basically a
> > > no-op if it's argument is NULL.
> > >
> > > So perhaps this can become (completely untested!):
> > >
> > > static void bpf_free_fc(struct fs_context *fc)
> > > {
> > >         kfree(fc->s_fs_info);
> > > }
> > >
> >
> > sure, I can drop the check, I wasn't sure if it's canonical or not to
> > check the argument for NULL before calling kfree(). For user-space
> > it's definitely quite expected to not have to check for null before
> > calling free().
> 
> Heh, turns out I already simplified this, but it's in the next patch.
> I'll move it into patch #2, though, where it actually belongs.

Thanks. I do believe that for kernel code not checking for NULL here
is preferred.

