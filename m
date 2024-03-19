Return-Path: <linux-fsdevel+bounces-14831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B1788055C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E94F1F23603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079939FF3;
	Tue, 19 Mar 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWQXHfyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF439FC1;
	Tue, 19 Mar 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876310; cv=none; b=sDC9GHU7L9wflMGMUGm2Ai/BSE+ou2rlkWKlDz5uRMk5XN/UWCQ+MKhfsun57N8ZI7l2HuNDc2a/WdPIL46Ii+N41JDONB4jOalwrkcblOxTuRMEvmwc56kezA1OKFuxKqxbtbEmsHQG0DJdr/3F/TmxaLKkXQrvm0+U6Eqir50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876310; c=relaxed/simple;
	bh=9kkXaFY+dcIbI8X8UIhDiP1ieJRGCHl1BCf86Hlb0x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfGbBJPA1vq7gob93GrupDzBNCAHcrTt8PB2572pJXF63F1pnOXKSEh4lXfIBBQGXOkPRgxSosblxLv+eXVLqi7m+n0H1ZzdIC3Wf9DwTzn6v64w8+UlN/XHkZ5WOuftHUP+b47TMKyB5mqNHixw2Zb1QKJmyT1dQYU/aQ86lTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWQXHfyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED755C433F1;
	Tue, 19 Mar 2024 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876309;
	bh=9kkXaFY+dcIbI8X8UIhDiP1ieJRGCHl1BCf86Hlb0x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWQXHfyhnnmjiec8fQp0CeFYwGUy12wgCxI7HGD9Se1v7oUHy1VMAIUdbu1lBM/Q7
	 SdEb3eHEtx9NvWV5fy8xtArwfACtWLX8B+Zm5fzd1KXmbXwZhHh26rD/fBRIa1dYdj
	 vyO3Fskz7fOlpO0zBZGgJcvQT6hO6x+x3RP+rguRXg5e0Qy6NLizPNfGoDM4NUEbAU
	 8ywh3unsoAwfNXXMgBS9Fc3WyNd7ACOdiexkGTiiSRi2kg9eNWQThJpCThBiZJasYB
	 BPOUuOThV+MAAQwiFGMs46Z6ABxhcpiuuCMaqbsB8kGgiwBjw4myoiEVTuZl37Ma7z
	 jyQc3thRC0AqQ==
Date: Tue, 19 Mar 2024 12:25:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, zlang@redhat.com, fsverity@lists.linux.dev,
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	guan@eryu.me, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs/{021,122}: adapt to fsverity xattrs
Message-ID: <20240319192508.GK6188@frogsfrogsfrogs>
References: <171069248832.2687004.7611830288449050659.stgit@frogsfrogsfrogs>
 <171069248865.2687004.1285202749756679401.stgit@frogsfrogsfrogs>
 <qwe6bnzuqkmef5hpwf6hzv5ce447xij7ko67vvasjcnzxy4eho@xnvyvawp5mba>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qwe6bnzuqkmef5hpwf6hzv5ce447xij7ko67vvasjcnzxy4eho@xnvyvawp5mba>

On Tue, Mar 19, 2024 at 03:59:48PM +0100, Andrey Albershteyn wrote:
> On 2024-03-17 09:39:33, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Adjust these tests to accomdate the use of xattrs to store fsverity
> > metadata.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> 
> Is it against one of pptrs branches? doesn't seem to apply on
> for-next

See
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity

(as mentioned in the cover letter)

--D

> 
> > ---
> >  tests/xfs/021     |    3 +++
> >  tests/xfs/122.out |    1 +
> >  2 files changed, 4 insertions(+)
> > 
> > 
> > diff --git a/tests/xfs/021 b/tests/xfs/021
> > index ef307fc064..dcecf41958 100755
> > --- a/tests/xfs/021
> > +++ b/tests/xfs/021
> > @@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
> >  	perl -ne '
> >  /\.secure/ && next;
> >  /\.parent/ && next;
> > +/\.verity/ && next;
> >  	print unless /^\d+:\[.*/;'
> >  
> >  echo "*** dump attributes (2)"
> > @@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
> >  	| perl -ne '
> >  s/,secure//;
> >  s/,parent//;
> > +s/,verity//;
> >  s/info.hdr/info/;
> >  /hdr.info.crc/ && next;
> >  /hdr.info.bno/ && next;
> > @@ -135,6 +137,7 @@ s/info.hdr/info/;
> >  /hdr.info.lsn/ && next;
> >  /hdr.info.owner/ && next;
> >  /\.parent/ && next;
> > +/\.verity/ && next;
> >  s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
> >  s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
> >  s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
> > diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> > index 3a99ce77bb..ff886b4eec 100644
> > --- a/tests/xfs/122.out
> > +++ b/tests/xfs/122.out
> > @@ -141,6 +141,7 @@ sizeof(struct xfs_scrub_vec) = 16
> >  sizeof(struct xfs_scrub_vec_head) = 32
> >  sizeof(struct xfs_swap_extent) = 64
> >  sizeof(struct xfs_unmount_log_format) = 8
> > +sizeof(struct xfs_verity_merkle_key) = 8
> >  sizeof(struct xfs_xmd_log_format) = 16
> >  sizeof(struct xfs_xmi_log_format) = 80
> >  sizeof(union xfs_rtword_raw) = 4
> > 
> 
> -- 
> - Andrey
> 
> 

