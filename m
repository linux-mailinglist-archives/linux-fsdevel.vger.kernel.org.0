Return-Path: <linux-fsdevel+bounces-47103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF049A99019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028B01B877D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EAB28C5BF;
	Wed, 23 Apr 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlcdM8UU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062028B518
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420696; cv=none; b=AV9LaOD5p+9ZUCdKNhAgN+blgyjSPxs6FqSInUN+F8TVgit6FY6cPbL7QcwmmJ3yKxaovSuMTjY8Miw592rBtJ58zz9BlLmu6QsYZFCk+9Z6IPgWn0DCPTVqRQIJ+T4Yc2dUzPbh/S060COfszX6/nXv6LpC4bvEXf9ELDS+cDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420696; c=relaxed/simple;
	bh=4R6lj0hZ4/p7O8oGQyGh1YZI8vXp8HHuwSAXkKuPK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loCDWSmYoXan6tq7vjWGIpm8CgvrFYSHFvVwJJr86qaI1IpHXqjiDvl6DzZZI7EwNcg42MDKvs6p6H73nxG1VZE+isdqFWv0Kr4jL8r5zdWXA0QVorI0bksy71ym3YT0BII5ie8A2p1TT9TRzE3NHNd8N+0danbnerRQ/WfSmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlcdM8UU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745420693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/XwtWlQK2gWEuKfXA1Y/H+Qql53usM87hFbg/riAys=;
	b=XlcdM8UUw0WsbsvlYUlnlAdPFpGgeXGj5rZXOKezteHaA1hzGKAso7RqK9xpMpTBRZsFTP
	BW/XSfjsOJWL+nHboG3umf1qL1IHAiC/g1E9G4qAGfS9aCm45CCc1UN+EdTXXSF7ArH3Bw
	zSLoxRetjmp7CPwMmDG5BeOEMvAzdjw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-oTHycUEbPA20G050xehx8A-1; Wed, 23 Apr 2025 11:04:52 -0400
X-MC-Unique: oTHycUEbPA20G050xehx8A-1
X-Mimecast-MFC-AGG-ID: oTHycUEbPA20G050xehx8A_1745420691
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e913e1cf4aso174183666d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 08:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420691; x=1746025491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/XwtWlQK2gWEuKfXA1Y/H+Qql53usM87hFbg/riAys=;
        b=W5AKXEHJ8KvaePU3N1yPBabUH+TlnBCRGs0SDtbgHN40ID77Y/fmlFzzce+Y5zk4sY
         f2GogdpRLZSqfcCmuhFEzZPOXXaa9vf2KkIwDOKZUuWQ/2ife1Whl5MEVbAhuHqU4ARR
         5cG7KmLhxCQIrf+FR6QAAx+/AGpiila70daNir8hdt+twzZhwclpdJ6b3z1l4LOaWfV5
         UxMqU+dkRu5T7bBnqDVFFb2VZOdSt3bGSpaFF2IkiDswrWx2JkxR5mG5nI03hFmDKvRb
         4HiHLz4GWyl7b3X7ZattMoRvfHcX7xeYNtQJUue+hI3y4G5U2xX/GtEriWXMO8ATS2T4
         blhA==
X-Forwarded-Encrypted: i=1; AJvYcCXJS2qsfKdxlxz6tuXFr4Qe2VaHrLLQ2eq/jln0XZ6SLxlUdZZyG6vv8EaiZ3zgC9H0eW9s97S1ZqyL5+Vl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FrbV5TomE0xBP22wCAlxwjEuklomUbgGvz8GzZtkg4HUDvqT
	JUEf56H91aOOqxa/hmH+9OJguZNJ6zh3Et9Ou0JFecxyOFyvCTmQgg8LzKK4sLi8/Fu8LOM4HC3
	Eh9ViigQet5d5kv+sBlIEu+pqnm31+YsA4Mq5jX0ERLt+7G1hIBayClM09ovyGP8=
X-Gm-Gg: ASbGncvyQ8Pv4u48DDyCVyWkiq1CSF+gE7QS6brSfMR+Qmo/+GcIajQEkrR6riVOAmB
	uXtqArqN00sNsOY0UEYErTd3MCzwWvZPuPPZhDN73qNTPYeIlAn0LNlLu3GNkAGRifxFpvuKVAk
	UXQDJTOAHr4abRaUuSYBd+WUHPPA+Sk4JzZsWZnjHfm0+8UTClLzlR4Xa7bILEv7PI5tj8e4jjH
	1qZ4jCfG3XANB5SByRZ9ZGZMpAnULhcb/IPiyqes9kb+gKtWpONRlZjsk6Hnl5XIZFKLWOsyjv3
	XpUQmyIiRdTgPRMN56ZtaH60kRh81YXEfAPnlXPVvVsuNSW8BFzy8es=
X-Received: by 2002:a05:6214:5085:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6f2c4562ff4mr349522286d6.21.1745420691108;
        Wed, 23 Apr 2025 08:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIAe6YgRzYFI//AuYLkGgT9bMQm2RTQxu8bUNb2e6etKdith1hNCEE0IZQWqDOiU1oDePTvw==
X-Received: by 2002:a05:6214:5085:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6f2c4562ff4mr349521466d6.21.1745420690350;
        Wed, 23 Apr 2025 08:04:50 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af5b28sm71585546d6.10.2025.04.23.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:04:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:04:48 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <ubimdwyutm47mlmtn43mbobtnwaxkmuse3vpgosbsh4yd7f73t@bbt7az62ybbb>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250420055406.GS2023217@ZenIV>
 <fzqxqmlhild55m7lfrcdjikkuapi3hzulyt66d6xqdfhz3gjft@cimjdcqdc62n>
 <20250423021547.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423021547.GD2023217@ZenIV>

On Wed, Apr 23, 2025 at 03:15:47AM +0100, Al Viro wrote:
> On Tue, Apr 22, 2025 at 03:53:43PM -0400, Eric Chanudet wrote:
> 
> > I'm not quite following. With umount -l, I thought there is no guaranty
> > that the file-system is shutdown. Doesn't "shutdown -r now" already
> > risks loses without any of these changes today?
> 
> Busy filesystems might stay around after umount -l, for as long as they
> are busy.  I.e. if there's a process with cwd on one of the affected
> filesystems, it will remain active until that process chdirs away or
> gets killed, etc.  Assuming that your userland kills all processes before
> rebooting the kernel, everything ought to be shut down, TYVM...
> 
> If not for that, the damn thing would be impossible to use safely...
> 

Right, that ties up with Christian's earlier reply and was also stated
in 9ea459e110df ("delayed mntput") description.

Thanks for your patience and explanations.

-- 
Eric Chanudet


