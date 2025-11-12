Return-Path: <linux-fsdevel+bounces-68083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC8C53F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 401D834831B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CF3587D2;
	Wed, 12 Nov 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIN//E/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0483587BC;
	Wed, 12 Nov 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971979; cv=none; b=PBQV8Rcj1mnpLFyCZ+9QWK258ITPOCMmp/PNn899SwtVfgNCw2rAfWBY9b8S9jI/4Cr4XWBv7Bua2hv7LI8Hy/7+yHs06blv6ovJnnL1ripj42hBXhnm4lBuAVJNc3lwsIeDXNsNWqTI/Fmia3Eu3e6A2+wYXT+7xmVQydtKT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971979; c=relaxed/simple;
	bh=M2QaiZHzhlVmKdu1Ysw4zOqywmtC0K6SP9pJS6pFKZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMk2ci0GjnJOZK0KxmCTeygp3Q+goH7Hn1FMmfD/d8S9AyTSwIUNTJ7D0kLVETBcSmmizXG+f7x5PXLoJPKWlj45wWahc+SumkghQfd+sDvC25vcVRi56QEwyEqlAAWK1Pk4HwnuvR9LCa1vDljHFLTIk89ZIWc+5vRJivhy9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIN//E/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB41C19421;
	Wed, 12 Nov 2025 18:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762971978;
	bh=M2QaiZHzhlVmKdu1Ysw4zOqywmtC0K6SP9pJS6pFKZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIN//E/oQ1vxpNSBmDP/lsaElc/MyeK8RIhdQpkM5IbjPQHN4ML5LjL5Vh7NHm3Ht
	 8xoh4ideAyxQt36+pfmpig3GCO252aTCFKzrAVezz0j/SjunEfBq1tBmZp9k/U2rTt
	 SMYd5gXvV7LBEFnU23qZI9eho9gtKrAhSopgk4r6gEm+iREOhGBZGc1LeUcYdlR+cz
	 T7RRggiD8lNVVfWAxMhpjZsVSUCPnUrB154RVac0OHSonpAkU8S1KA04C8gfZ0hTXe
	 Syjn+g56FawapdI75HAgt7T62lsAn1OdBy4czMoIN/6qTmaC44BosthBSnuzaRmfnd
	 FaIvqaD0VLtLA==
Date: Wed, 12 Nov 2025 10:26:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 04/33] common/rc: skip test if swapon doesn't work
Message-ID: <20251112182617.GH196366@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
 <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>

On Wed, Nov 12, 2025 at 02:35:32PM +0800, Baokun Li wrote:
> Hi Darrick,
> 
> On 2025-10-29 09:21, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > In _require_scratch_swapfile, skip the test if swapon fails for whatever
> > reason, just like all the other filesystems.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  common/rc |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > diff --git a/common/rc b/common/rc
> > index 18d11e2c5cad3a..98609cb6e7a058 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3278,7 +3278,7 @@ _require_scratch_swapfile()
> >  				_notrun "swapfiles are not supported"
> >  			else
> >  				_scratch_unmount
> > -				_fail "swapon failed for $FSTYP"
> > +				_notrun "swapon failed for $FSTYP"
> >  			fi
> >  		fi
> >  		;;
> 
> Could you also clean up the corresponding comments?
> 
>     # ext* has supported all variants of swap files since their
>     # introduction, so swapon should not fail.
> 
> At present, swap files don’t support block sizes greater than the page
> size, which means swapon will fail when LBS is enabled.

Well at that point we might as well collapse everything into:

	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
		_scratch_unmount
		_notrun "swapfiles are not supported for $FSTYP"
	fi

(note the removal of the case "$FSTYP"...esac code)

---D

> 
> Thanks,
> Baokun
> 
> 

