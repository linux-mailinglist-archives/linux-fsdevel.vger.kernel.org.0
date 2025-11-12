Return-Path: <linux-fsdevel+bounces-68063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F400C52A83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E86F834DEC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51632FF170;
	Wed, 12 Nov 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/IQIiy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F582877F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957149; cv=none; b=e+V1KclcXKRl/HSNTqIPA7uCVvUW8+xL23hMOQJgTJkpmJRAhyo4j+rTk8/lNWWnNyz4EnptOVV135y1086Dd5fx7/qnGcC7E+7s68evak8uI8IhRuSissk1w6MP0Kse0azcLdzwPLjFHMKJ0x0yJY/6dRdFmLAtuvonDMFgU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957149; c=relaxed/simple;
	bh=t+kYm055Q/4/JVRyEGrqO/ETHMRrbbqvnDg9NCLuJQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aulnhQFhIWXDY8DQSjw5bO3qnzFjHDMK7sHrMZFD9+6Z0NelvQUwR7D6Bv/8/70bVtKV9tD1AyyF5wn4HE1qf1MFqmjFXxQ7KeUVLrHE95AmuI5/MwB0Nq03SwotoHvxVn8CptIYX9smkWHY1nV34inlKtgYIMdYHsj1VEyQpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/IQIiy3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762957146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11dzZTZID/e9Yjzv4yjI8lw4KBQwSPfbDNh4cEy8sp8=;
	b=H/IQIiy3ykeWgaw7Q7k92J1WZ8nQydY0zQXphvUiLXoDjhc+vU1U/Y8c7fGJsMP5WUIpBp
	zLQ2G012m+Y/yOpWZorUQpWMTYjB2XdmafWIPNtVeLQs1hUHf3bBoTLH1LX1GN19pVTQJv
	Bpb4k37IFItw4QdN09dJ+0L7Xwd07qQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-XOLzT4QWP0C5oz8QabkWEQ-1; Wed,
 12 Nov 2025 09:19:02 -0500
X-MC-Unique: XOLzT4QWP0C5oz8QabkWEQ-1
X-Mimecast-MFC-AGG-ID: XOLzT4QWP0C5oz8QabkWEQ_1762957141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 785BA18002C2;
	Wed, 12 Nov 2025 14:19:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.179])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BECD31800947;
	Wed, 12 Nov 2025 14:18:52 +0000 (UTC)
Date: Wed, 12 Nov 2025 22:18:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: hch <hch@lst.de>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Keith Busch <kbusch@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aRSXQKgkV55fFtNG@fedora>
References: <20251031130050.GA15719@lst.de>
 <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de>
 <20251104233824.GO196370@frogsfrogsfrogs>
 <20251105141130.GB22325@lst.de>
 <20251105214407.GN196362@frogsfrogsfrogs>
 <9530fca4-418d-4415-b365-cad04a06449b@wdc.com>
 <20251106124900.GA6144@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106124900.GA6144@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Nov 06, 2025 at 01:49:00PM +0100, hch wrote:
> On Thu, Nov 06, 2025 at 09:50:10AM +0000, Johannes Thumshirn wrote:
> > On 11/5/25 10:44 PM, Darrick J. Wong wrote:
> > > Just out of curiosity -- is qemu itself mutating the buffers that it is
> > > passing down to the lower levels via dio?  Or is it a program in the
> > > guest that's mutating buffers that are submitted for dio, which then get
> > > zerocopied all the way down to the hypervisor?
> > 
> > If my memory serves me right it is the guest (or at least can be). I 
> > remember a bug report on btrfs where a Windows guest had messed up 
> > checksums because of modifying inflight I/O.
> 
> qemu passes I/O through, so yes it is guest controller.  Windows is most
> famous, but the Linux swap code can trigger it easily too.

Looks buffer overwrite is actually done by buggy software in guest side,
why is qemu's trouble? Or will qemu IO emulator write to the IO buffer
when guest IO is inflight?


Thanks,
Ming


