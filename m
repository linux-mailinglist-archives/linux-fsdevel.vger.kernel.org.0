Return-Path: <linux-fsdevel+bounces-1651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A87DCFD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520BBB20FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2C1DFDE;
	Tue, 31 Oct 2023 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bD8WmXoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F210797
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:01:18 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87CDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 08:01:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso8998261a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698764475; x=1699369275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad+zION83jYm3UNaou2a+6HPmR8A7N2sHF93CLrPIxI=;
        b=bD8WmXoZq+lmJgRaDJZjvnIdkocK0pOSIcK1YLCmO0voktYTHL2r39SIHDCvvBLx92
         UTjYPHIDYk/uOrTSaWKnBj8DRZXgqTeSuDQV8/unFJlyX/dEykgLYghsiMFUsQvacCwq
         eZ5LzJXmbVdUTJXeKP97p9pyuQS5XnaHfBx9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764475; x=1699369275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad+zION83jYm3UNaou2a+6HPmR8A7N2sHF93CLrPIxI=;
        b=OgqZKMEWK20fiwaixJpachiUTx4SiM+yIrvITsdDCjMx83zrpgIh0w6MKoLRzGej6U
         26tVFg4W8GDFvyJXFy+C6L1dyFvlz1bQyg4HjzjWgGOaRlFoY/HqgcbtaH9M+ncNoq2f
         laB8OGKPU75eUQhQP4YQflOf6qMlOGJIQxIxU46irvRdRaFSuJC+pR67TCvz2DpQ+xPO
         +7rm94aCq6/mJU346l0cOfhnW5jekJ7RPWXbjIOedvMcWaD48xcNqbrGY63WsTixx1pI
         fQT6gPS8qD/kMes9G5BscdngnlhXZ9fqFidypgTX2g6Ba2O2blwK9LSAyi09OApTzKl2
         fP6A==
X-Gm-Message-State: AOJu0Yxmk1HfNuBIuXLRDxO8kZ4JFWU8KJ46MYyh5IcjknzIkEDwWH3X
	bdNb0VVuMy7+8qR4m5Q2OHf9jJJYBOkAAtm7nagZhg==
X-Google-Smtp-Source: AGHT+IFuPm8mU9EAkP/k0XFqB2qsBg7cU1W2QNXpswUpmsO5AEhoG96XwLaHwCoh9hSieftSDey6yh885PX7UoPM4hA=
X-Received: by 2002:a17:907:5cb:b0:9c7:4d98:981f with SMTP id
 wg11-20020a17090705cb00b009c74d98981fmr11586953ejb.33.1698764475580; Tue, 31
 Oct 2023 08:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com> <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 31 Oct 2023 16:01:03 +0100
Message-ID: <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Oct 2023 at 13:31, Amir Goldstein <amir73il@gmail.com> wrote:

> Current patch set does not implement "backing inode" for FUSE inode,

What prevents us from storing a fuse_backing reference in fuse_inode
while the file(s) are open?

AFAICS it just needs a counter in fuse_inode to account the number of
open instances.

Thanks,
Miklos

