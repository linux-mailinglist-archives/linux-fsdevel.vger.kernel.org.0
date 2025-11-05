Return-Path: <linux-fsdevel+bounces-67228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60FC3844F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7A0189C5F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03552F0C7C;
	Wed,  5 Nov 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF/CrC6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A512E8B73;
	Wed,  5 Nov 2025 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383373; cv=none; b=p+YzyOECgUPs8AWn9AGg18r+YKVNe8TE+eBJmuwH+20I+kHfZUO6VSbibYQ9zoTyjA3eYw8MNEaovChPr23kSCuMsquBAHQpQ8IS4sRAk7Eif6O3C+d4zRyWze9WGAqWx1+GaC5Np+nuY9Jfa9Bp+Mf/OTGurCjT2/tS0qzw9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383373; c=relaxed/simple;
	bh=KVUjl+51Bg8bXVZjvs2CrjO+gcGngsts6Uy7Xsgql2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynnzic6MhhD/tp13ogdHR7kG1dtKn8MOLps/hZmvK5/fCGe5x5SCNi2FPMKXlmowKmrzYOgVmgqy4WcB2YKktyslp51cOtCaOqsNwA0Pukj+yfnGyDizjTnsnwxfgILVqrwDGLCWrux+GayYtk4H9TbsrBfZ2PoZTzyd+eP7iDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF/CrC6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E4CC116B1;
	Wed,  5 Nov 2025 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383370;
	bh=KVUjl+51Bg8bXVZjvs2CrjO+gcGngsts6Uy7Xsgql2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SF/CrC6yajRJqmwq6JqvFAM5zxx8GsS+JUNBoruhgj6TnM2yX4ep8F9jZGvl7+DfP
	 fDal18Vq89vjjOTKwTrK8QsA97vdLaBl5DY6ZRZP4O426kIizp6uAsYnclEezc2MqG
	 WxfDkHM96U42vkFPce7psPru43LpIOC9RX9ZVh8opVizkDw5gGEIY9zoIw8/d9k0hS
	 YmsUYcjXwm1Ee0Fyvtq/lyIH39MfcaPVqSs2NXbXWjxLhDoejNz+35v0r3M2ChlN6C
	 EEtYQC3WkmqYvNylKsbvQaVWMVnEFFjdYVw0N01rVI9BMbTjLTH75WJEbmuBnSD8u5
	 Pww4QpU3GUTXA==
Date: Wed, 5 Nov 2025 14:56:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 02/33] generic/740: don't run this test for fuse ext*
 implementations
Message-ID: <20251105225609.GD196358@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
 <CAOQ4uxhgCqf8pj-ebUiC_HNG4VLyv7UEOausCt5Cs831_AnGUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhgCqf8pj-ebUiC_HNG4VLyv7UEOausCt5Cs831_AnGUg@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:59:00AM +0100, Amir Goldstein wrote:
> On Wed, Oct 29, 2025 at 2:30 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > mke2fs disables foreign filesystem detection no matter what type you
> > pass in, so we need to block this for both fuse server variants.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  common/rc         |    2 +-
> >  tests/generic/740 |    1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/common/rc b/common/rc
> > index 3fe6f53758c05b..18d11e2c5cad3a 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1889,7 +1889,7 @@ _do()
> >  #
> >  _exclude_fs()
> >  {
> > -       [ "$1" = "$FSTYP" ] && \
> > +       [[ $FSTYP =~ $1 ]] && \
> >                 _notrun "not suitable for this filesystem type: $FSTYP"
> 
> If you accept my previous suggestion of MKFSTYP, then could add:
> 
>        [[ $MKFSTYP =~ $1 ]] && \
>                _notrun "not suitable for this filesystem on-disk
> format: $MKFSTYP"
> 
> 
> >  }
> >
> > diff --git a/tests/generic/740 b/tests/generic/740
> > index 83a16052a8a252..e26ae047127985 100755
> > --- a/tests/generic/740
> > +++ b/tests/generic/740
> > @@ -17,6 +17,7 @@ _begin_fstest mkfs auto quick
> >  _exclude_fs ext2
> >  _exclude_fs ext3
> >  _exclude_fs ext4
> > +_exclude_fs fuse.ext[234]
> >  _exclude_fs jfs
> >  _exclude_fs ocfs2
> >  _exclude_fs udf
> >
> >
> 
> And then you wont need to add fuse.ext[234] to exclude list
> 
> At the (very faint) risk of having a test that only wants to exclude ext4 and
> does not want to exclude fuse.ext4, I think this is worth it.

I guess we could try to do [[ $MKFSTYP =~ ^$1 ]]; ?

--D

> Thanks,
> Amir.
> 

