Return-Path: <linux-fsdevel+bounces-60164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7838B424FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7D7AD40E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75E18EAB;
	Wed,  3 Sep 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LK2mYxX9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501EC78F43
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912829; cv=none; b=HgQEC0WCvl93bCV6ZV7yP6txxfXdXr6EuO5DbRtLY7LfEba/Q65+UdEg8tKTAZKbe8rGHk0e1ZMXHEG/frmYYRQjMM41/gauFVbZvuX8r5mHn7K9ViE/0kv+TTQjp1CVAi9pQTGag6hOKdj5RO3tAuTporaCqh0NT7BWJZ1pnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912829; c=relaxed/simple;
	bh=9InNAQJ7gpEOtC9tdOkNJOUGLaAu3PFitzqpLxBGzQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orY+BgFjyIOhvw6n7M5CABg7g9WqKPI1+XkXKE3bVKb300cI7+S3o8M1mrMf68wht8n7PywdSSF3rTATaqzbFXUp3prP4UN/Twy/fstATVcBzecGwdVViICqFfGum58NUYR9i5z2r8XFSgO+CCBqiAdA6GpvGlDTwfXXX4hDyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LK2mYxX9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b326b6c189so191851cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756912826; x=1757517626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp+J43QzeSA3ipi35Z3UrosRjV5eUSYx6Z1a047sK5w=;
        b=LK2mYxX9aN2Y/Bz9AEOM1wZyw18c9kIqPCMlOJQzgt864bWbiP5JigA8Oc/6bvVm5k
         C/q1n4aEKdhFihCBDOFP+bMR+o4nJEn5PKERYiEgKuevkSk9nRjv4tkcM88NvzVFy/0i
         +trrL75rTZ1PObcPfe7V2DNHwavHac53/wowI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912826; x=1757517626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp+J43QzeSA3ipi35Z3UrosRjV5eUSYx6Z1a047sK5w=;
        b=CJ4g/eDmfnrAMjde61v+Iisamfv0Ty4/6ACmuRWpJGTw1HEA3zT+XARY6eVBYGE0Xz
         xfTK6RlVqq/8lUOm90CYJx4evPgBw5MS5HfWe0WUZKCsT9jr8gauRLlFQZokn5M2P4Hu
         DhtNNBjvZQN59pWAb2zkDkkJ6diqtAatVVsHNYrLDZsQJKWWB+PH1qMNfx6kkTIPQRXn
         oAZErdV0REpp8GBfA3W0hq+mOPkmhltldsWgKOKIWYWAD08Ru5cWYnw83Sz27qc3F8+A
         yA2SAqZnW4Du0q2uGc9YIMkPGT8F9keDeBVUNBT7u9wpUNicKsoPXGrLAjP62hTzxPPu
         rKnw==
X-Forwarded-Encrypted: i=1; AJvYcCWn41b4AhmnqRwt9p2hKu0ORPuj43CbEXYawyfYppYSAXWC1FHXC8KTnpTT+vRE2nzPxXLVebBR+r67OAlH@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgmzuk5DajXJ9sgvtmeAbknK7s/Blr4RWkOgSl348zEiQM3vQ
	ImLYxwz/+rZmfPGJ+vER0Co2cFRzXrvrbOUxLwBb2/HC+jqoIqOwEMemy6gd19r9ZaKxhV+QMdf
	fMzE+OqbMRPzmVGSiCck67QJNQ7qoc+qiEL1BaWBbqw==
X-Gm-Gg: ASbGnctAwkuAr/pY9FIcGnFayZerSRzlaMJvDL80uBtRJFDn1WVDM4FcoRtFYRGh9oD
	NtsAsjojBosxZQz2KlvGctUr0J6X5DFSsuatOXKylsXQ+T69ftTDsyA368K3tgybTBUTcvBC26L
	i9dCUJu/cJYztKDM1oh5onKrhK5hNZ2TQdum0Eztoixj2tCvbd3U2GLFcFyCI9w7Ss0nJKH5O08
	d1oSW0wMA==
X-Google-Smtp-Source: AGHT+IF5fF+jyyHqxnhzSEalVmV75mrF2TBJ09+DMCRFs7FSnX7qLRnanSbR82YN+NfxpfT2KoNv0m6fW8eFg43Sck0=
X-Received: by 2002:ac8:7f0d:0:b0:4b2:8ac4:ef5a with SMTP id
 d75a77b69052e-4b31dd791f2mr201676391cf.81.1756912825001; Wed, 03 Sep 2025
 08:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708568.15537.7644981804415837951.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708568.15537.7644981804415837951.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 17:20:13 +0200
X-Gm-Features: Ac12FXxx2ejnJZj2Eflz9uh0Pqu4agB2MWu9zI8tgTQJ7AhyqJpcEy-q1wBv9Xs
Message-ID: <CAJfpegv2xzmMCN9Gvy=4Z-vC-ENM-4MoKRwoQrC39jfoa2q-Jw@mail.gmail.com>
Subject: Re: [PATCH 1/7] fuse: fix livelock in synchronous file put from
 fuseblk workers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:50, Darrick J. Wong <djwong@kernel.org> wrote:

> Fix this by only using synchronous fputs for fuseblk servers if the
> process doesn't have PF_LOCAL_THROTTLE.  Hopefully the fuseblk server
> had the good sense to call PR_SET_IO_FLUSHER to mark itself as a
> filesystem server.

I'm still not convinced.   This patch adds complexity and depends on
the server doing some magic, which makes it unreliable.

Doing it async unconditionally removes complexity and fixes the issue reliably.

Thanks,
Miklos

