Return-Path: <linux-fsdevel+bounces-50140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EFAC87D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5071A4E0D8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3441F5425;
	Fri, 30 May 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzUL6wHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F812209F46;
	Fri, 30 May 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582687; cv=none; b=U2O4Bj/5eaxVhEarYfTQxbcDcE0n60fwb1kohbL+Akt+oh/LU7NYx/iRN55+ygeKUOcrcOcjePM87W0HR6C5gcH9kCLjZtdDufGbxiK7exGcRmN5omb4qH711j2xBLqRUlZjOoIL4LNYR+MBOV9TPD3F/N1dCdkKABgxaDLzbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582687; c=relaxed/simple;
	bh=ec41PG49I/K0HIAeno/rpOnJa0VI0Ixro906bMEYKKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDTdqkJFsyC7gLWipR2WXe1BJ+BgGJ/P7cWbQ+xAJ6sqgU42q/zPaAC+XRN1BrbcM5sfNroNtn4Vy6qi8losq87yQFuZHpsk4e6QT14VlW9CWv+xD1//0GtLXqEJ7NjeHUgaoTBjeIun0SQlI3a4hm4P6/q8Wv8R09leUwkQX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzUL6wHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077FFC4CEED;
	Fri, 30 May 2025 05:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748582686;
	bh=ec41PG49I/K0HIAeno/rpOnJa0VI0Ixro906bMEYKKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzUL6wHkolrbfAyxfUMztknnXEm3WD4rqsV5GqZhEkGHtltzL3bjqh+CxOaBFGH2f
	 eG/b/cvxAohke+eNF2GG/GjNJHiK4wTO8zQ/Ujeg3JZFqvj3LmDgsaqsFyAmLijGh/
	 SWmAOSXXhD/OiDBQLQIZyflPiUbLtNiW2CvmgBSpfuF4nGiTOM6vu3Cp3fYjG4NDu2
	 kU39Fs0NcHnCrvztoIRUqgKBiJUE9P01tQx6n7nIIWCO/5DjSQJP9SYkfxsKXGE6HY
	 8Y1izxG/dHrx4+bX6/cuoTGIQoRac0S20HLmOfZU+9QYxQtAHRD44Xp1CPXkxtCPPZ
	 woTnX1mQ8ZABQ==
Date: Fri, 30 May 2025 07:24:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz, anuj1072538@gmail.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, hch@infradead.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
Message-ID: <20250530-raumakustik-herren-962a628e1d21@brauner>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
 <20250529175934.GB3840196@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529175934.GB3840196@google.com>

On Thu, May 29, 2025 at 05:59:34PM +0000, Eric Biggers wrote:
> On Thu, May 29, 2025 at 12:42:45PM +0530, Anuj Gupta/Anuj Gupta wrote:
> > On 5/29/2025 8:32 AM, Martin K. Petersen wrote:
> > > 
> > > Hi Anuj!
> > > 
> > > Thanks for working on this!
> > > 
> > Hi Martin,
> > Thanks for the feedback!
> > 
> > >> 4. tuple_size: size (in bytes) of the protection information tuple.
> > >> 6. pi_offset: offset of protection info within the tuple.
> > > 
> > > I find this a little confusing. The T10 PI tuple is <guard, app, ref>.
> > > 
> > > I acknowledge things currently are a bit muddy in the block layer since
> > > tuple_size has been transmogrified to hold the NVMe metadata size.
> > > 
> > > But for a new user-visible interface I think we should make the
> > > terminology clear. The tuple is the PI and not the rest of the metadata.
> > > 
> > > So I think you'd want:
> > > 
> > > 4. metadata_size: size (in bytes) of the metadata associated with each interval.
> > > 6. pi_offset: offset of protection information tuple within the metadata.
> > > 
> > 
> > Yes, this representation looks better. Will make this change.
> > 
> > >> +#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
> > >> +#define	FILE_PI_CAP_REFTAG		(1 << 1)
> > > 
> > > You'll also need to have corresponding uapi defines for:
> > > 
> > > enum blk_integrity_checksum {
> > >          BLK_INTEGRITY_CSUM_NONE         = 0,
> > >          BLK_INTEGRITY_CSUM_IP           = 1,
> > >          BLK_INTEGRITY_CSUM_CRC          = 2,
> > >          BLK_INTEGRITY_CSUM_CRC64        = 3,
> > > } __packed ;
> > >
> > 
> > Right, I'll add these definitions to the UAPI.
> 
> Would it make sense to give the CRCs clearer names?  For example CRC16_T10DIF
> and CRC64_NVME.

Hm, I wonder whether we should just make all of this an extension of the
new file_getattr() system call we're about to add instead of adding a
separate ioctl for this.

