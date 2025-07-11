Return-Path: <linux-fsdevel+bounces-54663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A953B02068
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18435485F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151232EA48D;
	Fri, 11 Jul 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTFYiGsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E42274658;
	Fri, 11 Jul 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247706; cv=none; b=kjhZXjX/CSBAFa8WR1ecZsD9Q/AvRF41qEowajVXori6v5RBu9HV+Hqdbixf1XfMW1o9+YG7CotEGKSwSOKc3Km++AuMFR93J1aMT9uDw0e3F/jkLbTo+35ttHO/t5adBQPK3YD1Whs8N/I3pmoWwtidq7fjOcCzrCF1A9RJn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247706; c=relaxed/simple;
	bh=jJsQMAM8FiXHMdKty5y/XyaVhDgU86KQ3YEd2qZWf5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmzmP1xVEN+jH+cXYdjybrNJMLWQXxduGHC35Em9le3+S95TKSk8r7ge4FPwuNls8UfUH+F2BrvULaxy5i6mt11YnJHSkBEa8Cmf8ELk1qKiGJ8cax3f1I+HNeIMY9uj4gZzHLsYKL2v9Jzqgf4GKfoBKJIIGLufIS3lwvoubRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTFYiGsH; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ef461b9daeso1440786fac.2;
        Fri, 11 Jul 2025 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752247703; x=1752852503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCT28qnij7KcqmnQf/Iz1goywJwPmt6gNk4a8gqOzGQ=;
        b=kTFYiGsHLvnJeVjc79Pke84Q8yHizUDJeO/XjGFccOpz3HxyKyhs1dMvty3KNe1j21
         qMwq5UQLkeo8sbwhrzvgzTw+ZXOs+D7pL/eEKRHRDEE/o1RkanG4H1+2n63CZK3KwGsz
         AJtuQuJVUaPNxgGqpPJjQJm71GoTtq4BYgilY6vlPXgjRVzPs4qCBQWVly6rhoFvGo+1
         sRQc4eNn0xnSvHB8npRt/q/FSGUmwwOv4WOIILrHSYJL6hPEre8BcpX+NQFeqDg2UEvu
         UHNFE+IEZLDEI9dR4IOqqEVEZ2QhLFdoy16f6zAdk56Nt9n+5urLxk9yroVxxmg5wirN
         JF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752247703; x=1752852503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCT28qnij7KcqmnQf/Iz1goywJwPmt6gNk4a8gqOzGQ=;
        b=kht+7pqBOO7Z0fVZZvbKgdHFDOfj1MmP9D5ECg0DO8vzsTYHuaFHnpCq9/0RGZPOmX
         0NbkTBqLR8ebKroy1VA4mP4yO3sYwZBlJk58kRKoL7xJ5ZOTinl3stCzYUm/jmyMsohK
         p6xhTS6Wym1CTWO1j34C//l+YYUZA+459qtPorgiPxV6IaPG/g1KxbM6s/i/5B8TcUrx
         rNjcLel94kCFutACXfswMGyPqkV0vfIHef7b+8DYBaAIsrecjz10cLpdb/Ua0AyovSLI
         kaK83W7qjiKnAfDHGRfeHPVy0/4crOSIiZKIJZ2rtaH+0f2u3eMGWKUJKgB5GDUtgUF8
         ki1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP+B7TyO433zQ/LVrb9cRItbQUsFEctWbFKDn8lnKRg8oYNMz9Gu1ZW4oJb+4NHXWIwjAs+dpGIqxSqOR/@vger.kernel.org, AJvYcCUkGfNyZaacuSQ8eBdVxijASVuQbefmLfL14sLnctq7na3NeuObPj5JmvutmEYpV3M0ZRx7wa8FkUP+@vger.kernel.org, AJvYcCUpZBivixWXTUHxY2E4W0C/YptvjFfPDIwfGHwuOKcwrk+wwsLuda/QZMSbshM0UB/Pq3ezH/lJh0Q=@vger.kernel.org, AJvYcCVaND/CMv9y1L5yG84+LdR/Z+z1oO3JSoDWAKY5iRegl09MReb2zuWFoC0er3SCB5LVPjTh1Jbnorcmo2mbhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwahcPFeOr0CIBRNmwJW/V6/rfKg95q5+wsR5BmVL5tuD9iCxBO
	gfjvalZMsg+DHobNfGZBLaNuWrevHzVK/gHKXLSOYS0Yy5CN8siqWMPT
X-Gm-Gg: ASbGncuSk0fE6q4hG8gw9w/5JWgUmB2sa9dC67qRwrOmPqIytAndPBOCnsMO8kZycRL
	oZpUacBbBMuGiFRuggDcRi+uKLoU2bI+uQT3EJbO4ztg0TbUq7+MBV5CHHJidO8gsFJAS6u9AN8
	BpXyJcCdavOGC3/v1mkcHuVaTeAnP/1tlBny0WYcYGEyAKtroXhiuHYEWwsfHWp7FAiUXgHvfsl
	M17oAx9iLmdqHdAfHqy6o6W3L4SPthSq+e+0dMfoEuJtxXD6TBH/QpBh+HTZ36DdZF2rR4z+nTd
	ycMVilv9sGx62SYZzM3zE6xcmel0WH2RCvbk+uIovK7HOeQJWMRzkkbALsGhaFHCktAyk3t22p+
	Z0DNggIXd9Ox2XYKwTuVvk523MJnc2vje5KjEAkP6HhoCSUE=
X-Google-Smtp-Source: AGHT+IGzBgxg7rIzuTtcrrEUrQvsX4CkyLDr3x3XrSAFIZzmksXTQyVmWxDZllhKHdsEcj10mjoRIg==
X-Received: by 2002:a05:6870:6c14:b0:2d5:2955:aa6b with SMTP id 586e51a60fabf-2ff2b4d9b3fmr1955440fac.5.1752247703301;
        Fri, 11 Jul 2025 08:28:23 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:25b0:db8a:a7d3:ffe1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff1172e579sm762537fac.45.2025.07.11.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:28:22 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 11 Jul 2025 10:28:20 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
Message-ID: <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709035911.GE2672029@frogsfrogsfrogs>

On 25/07/08 08:59PM, Darrick J. Wong wrote:
> On Thu, Jul 03, 2025 at 01:50:25PM -0500, John Groves wrote:
> > * -o shadow=<shadowpath>
> 
> What is a shadow?
> 
> > * -o daxdev=<daxdev>

Derp - OK, that's a stale commit message. Here is the one for the -next
version of this patch:

    famfs_fuse: Basic famfs mount opt: -o shadow=<shadowpath>

    The shadow path is a (usually tmpfs) file system area used by the famfs 
    user space to commuicate with the famfs fuse server. There is a minor 
    dilemma that the user space tools must be able to resolve from a mount 
    point path to a shadow path. The shadow path is exposed via /proc/mounts, 
    but otherwise not used by the kernel. User space gets the shadow path 
    from /proc/mounts...


> 
> And, uh, if there's a FUSE_GET_DAXDEV command, then what does this mount
> option do?  Pre-populate the first element of that set?
> 
> --D
> 

I took out -o daxdev, but had failed to update the commit msg.

The logic is this: The general model requires the FUSE_GET_DAXDEV message /
response, so passing in the primary daxdev as a -o arg creates two ways to
do the same thing.

The only initial heartburn about this was one could imagine a case where a
mount happens, but no I/O happens for a while so the mount could "succeed",
only to fail later if the primary daxdev could not be accessed.

But this can't happen with famfs, because the mount procedure includes 
creating "meta files" - .meta/.superblock and .meta/.log and accessing them
immediately. So it is guaranteed that FUSE_GET_DAXDEV will be sent right away,
and if it fails, the mount will be unwound.

Thanks Darrick!
John

<snip>


