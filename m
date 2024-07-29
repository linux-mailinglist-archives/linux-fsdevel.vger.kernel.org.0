Return-Path: <linux-fsdevel+bounces-24522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3AC9401B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 01:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF83282E54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A918EFC9;
	Mon, 29 Jul 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="guOnPFPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210918A948
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722295171; cv=none; b=E7VY0ZVXnCBJzT+yCqQIOBojAgSfBhSDvzOj+Y0OCMfpwASI2YYyR8Nlh3ypM1QEuSIqrF8zLWW5TjYM8kZJeKk5Q9oWzGV5KyarR5gdLbTAHfAb/IX5JXMlq4ghoMk3uWmptMvgHXakH9tFAadi40T4dgLWt/BPjj89FSbHnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722295171; c=relaxed/simple;
	bh=OHOVO4dxB3APauYeyYI+8Ic96yRsKCBkvy6zgnD8xWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZJpz/Ro5dpkFv7jIh3CkB56nhfXWxre+D4rkg4zlrKTIh7mEdYsbZjLxGgtWZ475ayMW5ccPld+I8OxPHQ5pqii5YYwPN+mKzRDchqiWJiNeDJppjvjSIr1puhZv5VrzB8ZPhGVinGbbYV55dA5JlB/8RpR6dA2FLMTkEPGoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=guOnPFPZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc5296e214so27389645ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722295169; x=1722899969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kihfTujYbv2E1XGq+VQixBC4l+TTMCr6DBpIWmnfqrM=;
        b=guOnPFPZRNdRSHj5O9pLnp2KPEUVd2YPSfY1gFfIwhA6TLAlFHzTE1EpKetRp7T7v0
         bIVmQswq73PISeOxMqD7SLl6mPRTLcuzZgM4wn8cvyHlaLyfXeo6Evxn9/CV5kVbKlft
         pHryclYSUX/l3cF2a4DNg+SNAF23TXCpSaerdAUtonsdgLvjcr1Bj2fseQN3WTgYtrkU
         TcE4WcULwNlTyTONN9+426q2I756YuntohtWigtnn84q2F6qvM/+BE8ng/uW9e8AMsjM
         0YRO9ZhDwaHHo5CUR9vy6bCJajO/xn8PXb4pnDTZus7dE87UwWBW6MsxtlAfqpHCly0c
         bpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722295169; x=1722899969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kihfTujYbv2E1XGq+VQixBC4l+TTMCr6DBpIWmnfqrM=;
        b=QMuqdpINbFkgjIZl9pDFBaDZ5kVD3nCIGHBQ6jgHDYcr8Et33vKtsaVJXIkkyoDrBo
         1eMK6VAMq6X5HgPHwP+Pk2aHpTQkkSgsM6nwkm9hX/lMMpjpIG2hHQULbAJpb3PpBqKz
         NLNZrG5UCrKAxuIEm40RvuRLzdlAahp7tQGDQHNOPwEkSRY8ch9z8FbTmOYwChUtT/2M
         2mbY9fLaqPQsxyecFsX9Jp9HnoYkAlBMIrsb3Of1nHW1D+co99h+9m9pgL9L3hMd2cqc
         ikWDbFZbAwiGcmhlfEWVh+6St9jNo4j7qxhldLBC3kz7Q/key6bxcs0ThrcXxFgsb4jD
         Oydw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rl+OsMB25oNhQC+xf5+bv2cDlKB7W+KtN6D54h4x+zk4gGjLIFSCjNYx0c49M9flS9FaYrG+B72SPORFkSJe1yOfTqk0qKzF78qkdA==
X-Gm-Message-State: AOJu0YyiMuttEYJU3x/6ewhM2XPwfDIcYOgy38NbQkxTUV/Jg/0Qchal
	P91/wDlvqvv7qbkS8mUz4ssBV2yh3UASyiJ/ML8hsO9hG7H8/Ouwiu4jlJbIxMg=
X-Google-Smtp-Source: AGHT+IFVnVpiGMv4QE3tIHnY31CZIyj8nSZogBjINNMpgFa1/B5ceMrCZ21SvgHhoE64ol7erQYeRA==
X-Received: by 2002:a17:903:22cd:b0:1fc:2ee3:d46f with SMTP id d9443c01a7336-1ff047dd5e0mr145558165ad.11.1722295169539;
        Mon, 29 Jul 2024 16:19:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffcb9dsm88690665ad.306.2024.07.29.16.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:19:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sYZeI-00G4Uf-29;
	Tue, 30 Jul 2024 09:19:26 +1000
Date: Tue, 30 Jul 2024 09:19:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Florian Weimer <fweimer@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <Zqgjftq6H3cDO8D0@dread.disaster.area>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com>
 <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com>
 <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
 <20240729.114221-bumpy.fronds.spare.forts-a2tVepJTDtVb@cyphar.com>
 <CAGudoHFQ9TtG-5__38-ND4KTxYCpEKVv_X9HhZixcdnVMUBEwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFQ9TtG-5__38-ND4KTxYCpEKVv_X9HhZixcdnVMUBEwQ@mail.gmail.com>

On Mon, Jul 29, 2024 at 02:12:15PM +0200, Mateusz Guzik wrote:
> There needs to be a dev + ino replacement which retains the property
> of being reliable between reboots and so on.

Yes, that's exactly what filehandles provide.

OTOH, dev + ino by itself does not provide this guarantee, as st_dev
is not guaranteed to be constant across reboots because of things
like async device discovery and enumeration. i.e. userspace has to
do a bunch of work to determine the "st_dev" for a given filesystem
actually refers to the same filesystem it did before the system
restarted (e.g. via FS uuid checks).

Filehandles already contain persistent filesystem identifiers, and
so userspace doesn't have to do anything special to ensure that
comparisons across reboots are valid.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

