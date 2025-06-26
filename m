Return-Path: <linux-fsdevel+bounces-53051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C360AE94CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 05:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914C5175D37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCE20E32B;
	Thu, 26 Jun 2025 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="3NzRWHAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B61E9B22
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750910285; cv=none; b=N5Y696KxmV0MRnVgZ+XXOUWjzZNArNSN/Kvf8SrWOFx0YAtZalzX+itWASDA8I3WeNB6U4Po1fBeAT1ZNbetCPrppgY3iVE2yMd2kbU9tek4XmOwsbsbKVbj8WV8eDUgEsTo+9eNA/OvIGkLOGtaWUKdPzpbg5QljCpuNgU4Gws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750910285; c=relaxed/simple;
	bh=T2Miax55TEaH5XXrNWxmT95KXQwslFMTuIhlDQPaD6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlsgTWPjwdEqSUj1CuirfJLL2salAJITAjZFGE+MOdN0BWiQCLpVW0Lm9ExJvcfBYTD8G0j4IW5I3jsipWy3APjq/VLhpWl18Gb8WfXtfblDxtY/an+QU+LF2mfumRu3RePkRFolavae8Y8P0R/+cRcEJLoJIbmv7J/TA0P8N+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=3NzRWHAm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748f5a4a423so439159b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1750910283; x=1751515083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukewhoDGjvLSFodXCnO2Wi7qwdFCCxAWQjKm3BxoyQw=;
        b=3NzRWHAm72ObkQsmlY+xEArO65buF439G7C0VhjZEwSSIe2/gnAnYiYiHzpFnXsf43
         8gZ2H46RzbSiL3nHERBMuO9hTELT4lmYsekqVMHyq9UHhnykJs7/OzYeDdRYRiILApW2
         WgRmsWcK6thNMXyAH5wtS9T1LKy+qDK3JOQZS2D8uR8mIqIr9QwznFSA/PzVL7l/S1gw
         AkF0ABxBR+0Mk7vBqoxomKd06u9smeX/eGdVvF+OFADKqarURp2hzLSRP2lUnYuojHC2
         MhHR3or1gS8hxXAc5HBk+g7SCXksXr8g7KqRkERX+Yg+MgUTis23Cwlyh8eLV4jGdEYC
         3R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750910283; x=1751515083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukewhoDGjvLSFodXCnO2Wi7qwdFCCxAWQjKm3BxoyQw=;
        b=u5BANYz2iyNhBfAkoi913OZ914OdjvqOq+bL3D6AG1JTFmNSqCC8d3lGSEraAylgw7
         fT4O1epoTvcPdiz/jEbVndJRKLUefSRRfz7cWpXKbGITyri/J/pz4uROs+cHSCnkI13n
         vFa2fAn1J2YbBiRC27mLY4zWCAx4q82AcEX7nrRF+WXuo2VyM8ayPAbOiOZXuFl5MgQ/
         pT5Q4mPvMoMR1VrNFC/1zDg/q25taOK+SMUc9kSJDxAhHUCnqXxkNGmJjDM3UoCrS6Qx
         ecUrxSyt8EB0fd7gPi171Syk4s+AyWyU9M27oTACdXsKG/5oNf47c1xIcCYnfj/5+cSC
         pVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEPcs9beTDXBuldgJcRnoATgpo1twQlg8bhBLx1zpaMCl2SLEEyXvz481Y5LCxOIydVgZvXWXhdfX8Q14y@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhiU9l+wtpXRvOKHDTe5xyoIQ8KTHVb10IOSK/bcZTE4JYb2x
	xxzEVxjZOCL2TEytX/qLZpLnoIODDVdLyg4fuXBGvwmjyygOonV04bHsPMdc5MIidb8=
X-Gm-Gg: ASbGncuv1EAPQwkNHD9a/T7nsKoQSYOYbVDmvMxdEiTnAyW5zdwipIelOPvxTcf9h0s
	8M2aB3SEnky0+ouaS8RUzSScHbOnMsoBVLM15OvTPzDSNNoyo2y5k2bVVWiAzVHZEkFzlR4Af1K
	bNBrvszr30IMYL4zPx2kFBqWolsLnOMp+L8CDmdXl8H8CcdAzf2GynGfHFUhfQAVgsYvDli/rX0
	zvkSExdIQof2G4EX1TCu+a3YVteV4B6lUgmzNXTGpGoHu1omrA2Z9UoTFbG+MgGrWJhjje4XcSH
	9IUdRjmp2DbnvChoshfRpXDZhCrS1PXsWXPV7iZ/IP/6qSpcqFBM+B9bxIHhaB4iV6N8B7X2g6N
	87s9Ffuli1yvIncNn9DRbrDkiaQgVFzCYYXlwGvdiOPf688dE
X-Google-Smtp-Source: AGHT+IGfMj1hupvnOX/mD73qau+DpHSUC+w5eDTmeBI+czHsebUdwnvPvrfHC2KQ/TS+fSfAjMVx1g==
X-Received: by 2002:a05:6a00:c86:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74ad4059d79mr8122379b3a.0.1750910283181;
        Wed, 25 Jun 2025 20:58:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88548dbsm6145745b3a.133.2025.06.25.20.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 20:58:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uUdkN-00000003L0Q-42Kg;
	Thu, 26 Jun 2025 13:57:59 +1000
Date: Thu, 26 Jun 2025 13:57:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aFzFR6zD7X1_9bWj@dread.disaster.area>
References: <aFqyyUk9lO5mSguL@infradead.org>
 <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org>
 <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
 <aFvkAIg4pAeCO3PN@infradead.org>
 <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
 <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>

On Thu, Jun 26, 2025 at 10:41:47AM +0800, Yafang Shao wrote:
> On Wed, Jun 25, 2025 at 10:06 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Wed, 2025-06-25 at 04:56 -0700, Christoph Hellwig wrote:
> > > On Wed, Jun 25, 2025 at 07:49:31AM -0400, Jeff Layton wrote:
> > > > Another idea: add a new generic ioctl() that checks for writeback
> > > > errors without syncing anything. That would be fairly simple to do and
> > > > sounds like it would be useful, but I'd want to hear a better
> > > > description of the use-case before we did anything like that.
> 
> As you mentioned earlier, calling fsync()/fdatasync() after every
> write() blocks the thread, degrading performance—especially on HDDs.
> However, this isn’t the main issue in practice.
> The real problem is that users typically don’t understand "writeback
> errors". If you warn them, "You should call fsync() because writeback
> errors might occur," their response will likely be: "What the hell is
> a writeback error?"
> 
> For example, our users (a big data platform) demanded that we
> immediately shut down the filesystem upon writeback errors. These
> users are algorithm analysts who write Python/Java UDFs for custom
> logic—often involving temporary disk writes followed by reads to pass
> data downstream. Yet, most have no idea how these underlying processes
> work.

And that's exactly why XFS originally never threw away dirty data on
writeback errors. Because scientists and data analysts that wrote
programs to chew through large amounts of data didn't care about
persistence of their data mid-processing. They just wanted what they
wrote to be there the next time the processing pipeline read it.

> > > That's what I mean with my above proposal, except that I though of an
> > > fcntl or syscall and not an ioctl.
> >
> > Yeah, a fcntl() would be reasonable, I think.
> >
> > For a syscall, I guess we could add an fsync2() which just adds a flags
> > field. Then add a FSYNC_JUSTCHECK flag that makes it just check for
> > errors and return.
> >
> > Personally, I like the fcntl() idea better for this, but maybe we have
> > other uses for a fsync2().
> 
> What do you expect users to do with this new fcntl() or fsync2()? Call
> fsync2() after every write()? That would still require massive
> application refactoring.

<sigh>

We already have a user interface that provides exactly the desired
functionality.

$ man sync_file_range
....
   Some details
       SYNC_FILE_RANGE_WAIT_BEFORE  and  SYNC_FILE_RANGE_WAIT_AFTER
       will  detect  any I/O errors or ENOSPC conditions and will
       return these to the caller.
....

IOWs, checking for a past writeback IO error is as simple as:

	if (sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE) < 0) {
		/* An unreported writeback error was pending on the file */
		wb_err = -errno;
		......
	}

This does not cause new IO to be issued, it only blocks on writeback
that is currently in progress, and it has no data integrity
requirements at all. If the writeback has already been done, all it
will do is sweep residual errors out to userspace.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

