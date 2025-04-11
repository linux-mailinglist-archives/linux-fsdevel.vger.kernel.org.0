Return-Path: <linux-fsdevel+bounces-46304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8118A86583
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 20:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79868C1D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3D26656B;
	Fri, 11 Apr 2025 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sl+U+9/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C32641D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396245; cv=none; b=tscwvayfKdo2Gp0etuKem1cqXRgwA6QCNdQdum83i93tlejm4ADoyjqVJvgorA7/2o4bc1DYIhgYSS6AH3BbJoJovsZjeM51+E57e5MHpD37yciOMjxDjBM+iMOem2k0bfHDjPSSr4KWYnugskjjYoWVI57BL+1Fd6M4f6foJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396245; c=relaxed/simple;
	bh=gbIjlJ4/bbqhbywHWi3G5k1aJY9GGtE24f8qSVkHBcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTr0NsSBAomNpJHO4nwsZi0fErkG7yxFMhQq7x4chStsfX9a9ieUHZzNF5M7eXZpnDOdQdEwX8TU1sqFsH/szXFS3ftUKa+RANTLtvHiN3fl3UIZt1rlxO1leXn9JGKSjrAZcgeOKJIjxRZHJ2/OyfSW6dCDutwvwtuumGntEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sl+U+9/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744396242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hRteb3aRXSBlgcZhgi2F2fUtSDh4vvSsqZj42m4O6k=;
	b=Sl+U+9/9owbqlUydWXaqcBio2Y2XoZ+M9/T8jWKCynt0jNSrnIOcl07xuClfC79tJFCGL3
	u0AcahGRyHsRElgKW7LUB9YwTwNhtlHhR1FdVc+yWaGhQK9aFG3YE/eoImMX7l9MxtTSJI
	AmydZDJa2VGiah9Uyhp3stQffJbdPoM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-hw8NqFSWOjGcOPN6R6Sv7g-1; Fri, 11 Apr 2025 14:30:41 -0400
X-MC-Unique: hw8NqFSWOjGcOPN6R6Sv7g-1
X-Mimecast-MFC-AGG-ID: hw8NqFSWOjGcOPN6R6Sv7g_1744396241
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e91ee078aaso38647366d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 11:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744396241; x=1745001041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hRteb3aRXSBlgcZhgi2F2fUtSDh4vvSsqZj42m4O6k=;
        b=wC6ABmlNRbP76mOoSkQbdeJo8oHITSZKpPWYJk2ymrf7soVDoxuZifgz1cjjYesErm
         X1aRvtb/yPN0xyLNg2/11R1NrHpm3fIj2Ap9ZBGmfUF/IBxo4E0bGG/S0352metePgDl
         Q81oTSLq4g04XZ8m8ftcm7N4bmUhi16hUNdQPQnq72Ef+2Cg0IAhaYRXbmZsSqGTN4cW
         s577DHKwTq5nixFl02XvU1QZz14tvHd5dbpjw3O1jqPAnfXGu+rO246MSYEcR4IkH7zE
         FpU3h8xb0jOmdYLxBhGjcaVcm/PqKOFgQd+XIJktMGFtoaTkhUiqOiHF6T4fZuytQyHO
         96HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2O6P1Mz5YXrJfNvtg0jzs+gkjeokBPmPXKqn32cPgPFxxpHWuXhxw0gsxhfw1q3fd4gOlEdVMvts0fjhV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/Jh8J2Ej9CLvii/TWRwj62zsW+a9KCD837vd5pBM5rZn+dQ4
	3YOgrGqzKAQW5L1OKaOpjPmWSiiJDVJUtuogndkF2z9/iKGghn4G9YTQVtvpure2BaRCGE2Nn0K
	P4g1+/ybZ2eF7Fe5wY2mLGjJUe44St9KNe/2QJXvjJab4HxCdWnwt2VjZATREaCk=
X-Gm-Gg: ASbGncvuK1h6N6xXgWFRYw6rs2eIOTyf5wOg0tLR602D4KKh+k8PH4Bpfwmwo5D5aNJ
	QfRq1LEBqefYm26TlHPIlHDLz4b0JjxXWxZVdMJKur0fCMKcH4T36MtwzYBnEPKsgaB4CQR7vr6
	Vsf08XMk79BuXjdDBtxgqBKTFA4QyapqUFlhCRZ5oJwkBr/lFD9FhWEaVg9Pq4EBjY418m7pktK
	d4xcsZhMJiXUN1H2sXziD0nJMePDNphLkHJ/W0p9qP8hLFpx3M8083MhMU+G11OeaFTOf6U/GzR
	AIbx3MTsG8cF2FU4tSzxBNzmIRYc73ud2++4Z9pjPrcRp0DHN2WxyM0=
X-Received: by 2002:a05:6214:1d28:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6f23f188908mr52497386d6.44.1744396240839;
        Fri, 11 Apr 2025 11:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGTdRAZGTWxZjNDqvRXfFHjzIuclHnT9UwsGZfzm19ZI8mK/0p0p6x/jTN+uifKPieH9BXXA==
X-Received: by 2002:a05:6214:1d28:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6f23f188908mr52496946d6.44.1744396240449;
        Fri, 11 Apr 2025 11:30:40 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de837f9dsm40270486d6.0.2025.04.11.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:30:39 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:30:38 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <zahvxexq572ud7p5nlbtty3attjn7h7fmlujhxxpdgsj346tpg@u3zqnfvrnh5k>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
 <43hey3rnt7ytbuu4rapcr2p7wlww7x2jtafnm45ihazkrylmij@n4p4tdy3x2de>
 <20250411-abgetan-zumachen-ada00fc3770c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-abgetan-zumachen-ada00fc3770c@brauner>

On Fri, Apr 11, 2025 at 05:17:25PM +0200, Christian Brauner wrote:
> > With this, I have applied your patch for the following discussion and
> > down thread. Happy to send a v5, should this patch be deemed worth
> > pursuing.
> 
> I'll just switch to system_unbound_wq and there's no need to resend for
> now. If the numbers somehow change significantly due to that change just
> mention that. Thanks.
> 

Thank you, I do not see a significant change in the numbers with
system_unbound_wq compared to system_wq.

Best,

-- 
Eric Chanudet


