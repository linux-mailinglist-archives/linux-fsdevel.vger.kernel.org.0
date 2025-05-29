Return-Path: <linux-fsdevel+bounces-50049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC161AC7C65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21C316B1D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CC828DF33;
	Thu, 29 May 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SCSJn2XA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4921925AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516920; cv=none; b=TLp7U9E+Hhk45Pmi5KKmdI9zN4SS7UiXNaVq5+rXIgMRSc31TP6f5moe6RTe6Ahb+OglEznqbaJ5Ch1n70UyR2jXe3NSezgPHXVP05YaMQ37asO6twZxBBXOt1YZW+40peNSBzWaQFNS7g9CoBzmZQ5GmycUyNm5Bi/PSYFEGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516920; c=relaxed/simple;
	bh=iZXzYIN24F+pfwiPreeyCICuGYF0+gjllr5OGeYyNo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcspdf7W8CheXd+cFV5XhSz8dhjMOepd1zsgXk1i8huc79ptLdWJ7NXZe+4pboj+nXLpG8j7xj0fKYejO6mjnVVcEzLy2JVbhmpP4C+VkHffga3Q1mwBrO3hf4to7PaBV4nOOlBbZZfQXEcpYZLEBkwV8yS8+DoHwYEU7V24flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SCSJn2XA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4766cb762b6so8955571cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1748516916; x=1749121716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSIOhXayNlFILbJyHd0DZBYxSCjybVEo0ScA6s5GuO4=;
        b=SCSJn2XA4FHAGn+eIW2a5t1NpuvwXbFNyKzfsExHoawZTjgOKmKMmxHnmrCuc9aLw0
         MQR77GwTuvusSSMvUhkoTJ27aweC5JZ6fCijJjR6wc20gWOduzVM5SeQC0j6dn0/AgRt
         0G12efR0QT0m1f6UDcCSRgtXNCl73TlREEQ9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748516916; x=1749121716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSIOhXayNlFILbJyHd0DZBYxSCjybVEo0ScA6s5GuO4=;
        b=o4mxNvGgGXXod/2R7q3/isuCUapY7AWh9KdOgTPcxcATzXNgFXprIL6ECkyykDxNX+
         /0gOoyhDD5F/pV25pB9ZfxzFUHE76ihUQMdGWptqNZuW/zJN1UDR4SHLAe57F0rHpcjB
         CAUGZ+raMmZ1gdjIPooDf6JTNc5Xajc23rsvl5/NGDhR68LvKjF3rUH2diL+SoKYsw5P
         H3SaBlspLprvjbv0+0dpdAcYSgq8w9SQu/42T58bHPTFEVxNM9+PFGJ3SCeejWyLekIF
         tNDFBu/3IfAdCPKGuoWF3HT3oMeZeeLncny/+n9lc076vj5SRhVmj0K6pO00DexEdGlP
         uHgg==
X-Gm-Message-State: AOJu0YwdoeaKDON7kjLPo7HW1Nnsri/SM0Dsk+0RlVmsCN91frDKXSjh
	Eti9W1LtpG3pA5uMs+GESqudNzIJVedM8mcbX43hp1bvaTKZ6c3/AJe/jFIZ6uflNICeP1+uLwA
	ztSXZIpx7fHY2UohJjbtR6UAguIR1Lz0Q5EMaibkknQ==
X-Gm-Gg: ASbGncub0kEuligZJ+F/xqPoIALExfEPa5YsApZ+V3BhcDA1ajatNVcgG824xPPudjr
	7T3O3rscBFCy9+tBejrK+Z5XH9d+uWNq+hx3Z2OSYZqXub0dj0ziNLrWG6/8KWfJsuOz8+3nWjj
	Ijd6jeasa8Bp572hitiY+cKly1mbr4XZ4gUVQ=
X-Google-Smtp-Source: AGHT+IHlzCsjSSqHlzTxy7r2hlBRho9lgiOx79Cr6d7xOtkTOusmDdlVRNa6VE5LeFYKFaq2SM0bs2rU/vrX+UKzdM8=
X-Received: by 2002:a05:622a:5792:b0:47c:fefb:a5a with SMTP id
 d75a77b69052e-4a432271477mr58424581cf.11.1748516916312; Thu, 29 May 2025
 04:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs> <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 May 2025 13:08:25 +0200
X-Gm-Features: AX0GCFuAuuVaLVkR3Pb8Pqa6RMkre6YqoMSXl4YIwBe52nOpviwbCOiM6rWjirA
Message-ID: <CAJfpegsn2eBjy27rncxYBQ1heoiA1tme8oExF-d_C9DoFq34ow@mail.gmail.com>
Subject: Re: [PATCH 01/11] fuse: fix livelock in synchronous file put from
 fuseblk workers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, 
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 02:02, Darrick J. Wong <djwong@kernel.org> wrote:

> Fix this by only using synchronous fputs for fuseblk servers if the
> process doesn't have PF_LOCAL_THROTTLE.  Hopefully the fuseblk server
> had the good sense to call PR_SET_IO_FLUSHER to mark itself as a
> filesystem server.

The bug is valid.

I just wonder if we really need to check against the task flag instead
of always sending release async, which would simplify things.

The sync release originates from commit 5a18ec176c93 ("fuse: fix hang
of single threaded fuseblk filesystem"), but then commit baebccbe997d
("fuse: hold inode instead of path after release") made that obsolete.

Anybody sees a reason why sync release for fuseblk is a good idea?

Thanks,
Miklos

