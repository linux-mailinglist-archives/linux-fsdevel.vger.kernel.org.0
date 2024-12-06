Return-Path: <linux-fsdevel+bounces-36602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F49E6507
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 04:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D0F289DF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 03:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818D194C83;
	Fri,  6 Dec 2024 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXGxgjzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6A190499
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455611; cv=none; b=rsDKIjckxzUCmACbfjUebLLx75+NxjFVSlkMOoAdYXgWPrWo+jkHXBVC1dfPFfQc4MfGPd6MuwD4BPNZ1hx5qf0PqE5TS7HrY0/OduMwO+AnPft8uNuu/1t5BFciov9PYbDy4zNMI86xHPOiTOT24ssArUkq3c/3I1kqCepi6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455611; c=relaxed/simple;
	bh=6vGxsefIxkc58TYn4uOYEIrq5i8/9jJVrEkfpbedAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyZVmNrhpu7Hd4LyQncj39K5wUnJOsgkxScMo+O7JtImJy+J1D3fIXk+7HLQOFJmWaniBKnA9Nne+bfOkji959XNmfksFzfAnQh8eRwCguiEmGt6YZB08HJVDYIbmhIwJA9lsxMVvmon2PY0SDPQ5wh1LDFDkDWWZlyVOW4tqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jXGxgjzS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1427908a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 19:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733455609; x=1734060409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yd2BxdiLUsU9te+wiWe+Bh65ViLVEN6K5aziPZKMTyk=;
        b=jXGxgjzSK5OtUcbtLcY3O4vSM2wgHwa4BmWWyLEwemEZ0M2hhO6dj7ZCTmilr6SN78
         iByUXPeV2dradDsb9W9bXv532jAAmQalLgsJrwupdYZ2YhkSnbH0Vu6mNpmgelj/PYOA
         ZovICWhL1iHdEy2mWmdVhdsNp6ZVY6fNIvvd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733455609; x=1734060409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd2BxdiLUsU9te+wiWe+Bh65ViLVEN6K5aziPZKMTyk=;
        b=C0NOyfqZfgiEsqMJt4HrL1wKyD/2d9MnKKhW53tynDbAQNmb2KHcSjEAeZPFRZTOZP
         ZTKYt8cYUU+oi7syLwN6rb8jIyatHB5lxMLoDgu7ojSGW4KnxBudiUmMc/MDyz9Ugmff
         Oyd+dGwq1bl8ec2k7LSBhjlOhoPG3NUCZIu0RBaVsvVFu/7hyZlIXSJDk+iqSICkpV1B
         1LkWRJhG+E7udiDcl5D0PbC0BAX5wQWwzGI6/jf6DTPp0C3SRJk3O4N7oWJbsaaoyUjN
         15KiwWZst/aekCWR0cssMQIj5xBzQz1YNgaQqvsD534xNz+Hc/2h3Ht0Gu24a9UMUn3u
         HIVA==
X-Forwarded-Encrypted: i=1; AJvYcCX0yRECph6ehIb5a4ANTk54VoGzC++ZC6hPl5Uw/LXLGcfwe6d3XfAk6NcijSbD0cCLwadTH3R61gIWMQw3@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdOL/No3kFADtKE00SG9WsobLXoXMfd8hTd43CSth2hQDBykH
	pGVQk2KIKx2AYtIP2ybb8diT5FPSyf/maSk+C7euZQjkozGgNYBt6Il36MUSgA==
X-Gm-Gg: ASbGnct0Fg7bDBaV9A7ql9kWOMIoxeYs7aLlt0JjQV6oLqYYWe+Kfjgjqx9l7YiWQON
	SPbVQ7oKWTasz8KAtVSC7CD+r4EkYUYS3z0klv1zXAamGcdicxnS3yoIT/PlfFQf/NGR2l0ZnbM
	JwolIoLjybXQZ7kfUfYfIYpMMYrg/XCt58UYhmeDUq/uhpkk3a8yPHQIndnoMCHiObkIkS4yTYQ
	3T9KbQ77b0q5D5zCdtUgm6M3k4rkqIZAcZmqxlLNavj/yiFrUHGrA==
X-Google-Smtp-Source: AGHT+IFhDY5Y/Yc2HdcE3Oz330xDDKAl1PzANgMJG5gfG9k8SDWpR1Z/2zzcTNfmHu7v8VM71rTwPg==
X-Received: by 2002:a05:6a20:c78c:b0:1e1:3970:d75a with SMTP id adf61e73a8af0-1e1870ad511mr2434042637.9.1733455609271;
        Thu, 05 Dec 2024 19:26:49 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5e1c:4838:6521:8cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157ad524sm2065295a12.62.2024.12.05.19.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 19:26:48 -0800 (PST)
Date: Fri, 6 Dec 2024 12:26:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241206032643.GG16709@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241204134740.GB16709@google.com>
 <CAJnrk1YwOTdbGp_Fh1te+hg2eQEu-CHO4Aik=6fN-mu12OHQ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YwOTdbGp_Fh1te+hg2eQEu-CHO4Aik=6fN-mu12OHQ4A@mail.gmail.com>

On (24/12/05 15:29), Joanne Koong wrote:
> On Wed, Dec 4, 2024 at 5:47 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (24/11/14 11:13), Joanne Koong wrote:
> > >
> > > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> > > +{
> > > +     return jiffies > req->create_time + fc->timeout.req_timeout;
> > > +}
> >
> > With jiffies we need to use time_after() and such, so we'd deal
> > with jiffies wrap-around.
> 
> Ohh I see, I guess this is because on 32-bit systems unsigned longs
> are 4 bytes?

Correct, IIRC on 32bit system jiffies wraparound every 47 or 49 days.
But I also recall that jiffies (at least in the past) were initialized
to -5 minutes so that they would wraparound during first 5 minutes
of uptime to reveal bugs.  I don't know if it's still the case though.

