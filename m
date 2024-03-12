Return-Path: <linux-fsdevel+bounces-14242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82B879CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6B1C216A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5814290F;
	Tue, 12 Mar 2024 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MuVoKAGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4261428F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274915; cv=none; b=NTM21m6Ait1w9Jm3n7/WSuc5OGvG+slPKCNrRHDDwmegySiBZPZpuaqgulECAGMlAovfODONuAYhXL+QSTx36xpVzIx7o11cfiWMP7j7S25+Fn8H5CtA2NG8mGdojI4BUjyT9FswUzTsXriyqk5TFUWa98IgL5fQYK9riQKcwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274915; c=relaxed/simple;
	bh=uBrGiE5O6AuIFTtj/jlLiZozZS5Y38ZEH3vQvSZc0eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PccoYAPH8WeO+QKJoXT+GmZy138yWpZ0sf8V2B2coCCHCZCgzVDJsh94MJDQb/emNW8gCwcLzgVviVLuuit6NOdgCIJycU7xBXZL65UqL547QY6bkfyooGA0yIEh0aZRearV3md2s+fP0JeN3OztvTv408pTeLs+OWBx1rF+QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MuVoKAGM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so54618666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710274911; x=1710879711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9hWOoexzYOGaCNkqMwBrhgeF73SnW0W5uRMgtvkkqg8=;
        b=MuVoKAGMZb5bJJTJF8C2EnnJ3k/C6X9EYQV/IN1n3ILBsqsE0V8RdpJ6SyeRMKkn+i
         2E5sK8uk0nG8RY/LVrLP0CklopZ4Ot/YNBcQBJVbyG/cKvo7TkvM1pPnBbMw2K607R1R
         B42PC3a769z5mDD+dGRRlNLIqyfPjkuC4up2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274911; x=1710879711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hWOoexzYOGaCNkqMwBrhgeF73SnW0W5uRMgtvkkqg8=;
        b=Pc606oaIcFzW6ks82G0DjwbtL2iLoOla8uRXpoM86ahfm3eQ1m5LEoIrNfsWfwNNSp
         YisV6rFXaKVhAy4PuGQ3tbz+dWxHxUtTqblnvMlEy1bTWcqdxwcPvZxOczqwi8zvG1OY
         +H8iRAs2mkoZCvTaOS5VOJPXqjVCKkZovGN78nAdKonbX3sKWFQ9aFSG1JKfsLwSICsw
         J9+HgRaAtQIs/EInPYAj+oNMhmGjlQjMjxqJZBmqjuVO25WKLxWfcnj0OAOfqIYGM5hb
         fXOnNK2QfnCOoogWwg7LcDitYup8N3HkdgYn8k10+zXomH/MV7+DM+PxiZ+7fdOf0Lbg
         oYvA==
X-Gm-Message-State: AOJu0Yw+NSQIKrRnwFRw3bzejmzWu/0eEc4COh6AMNbNxHuhy1uNsDm5
	9tat2VR7rF77ReC/bZcMWv4nOLIS467VCrSZiupzoFVsv6GswRFiU9EvD3RdjmEqNuVpX4wtnBk
	0/y4EUw==
X-Google-Smtp-Source: AGHT+IEq+x95MTxu59LGcHMp+68m2pmTSlb1IvKXB7HmYDC7njQMZ1lOySYMIGd46PNrnqUKOKA5Tg==
X-Received: by 2002:a17:906:ba8d:b0:a46:4771:4611 with SMTP id cu13-20020a170906ba8d00b00a4647714611mr2140984ejd.36.1710274911499;
        Tue, 12 Mar 2024 13:21:51 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906564200b00a4619ab82c8sm3026552ejr.197.2024.03.12.13.21.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:21:51 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44f2d894b7so52074866b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 13:21:50 -0700 (PDT)
X-Received: by 2002:a17:906:f0d8:b0:a43:d473:685 with SMTP id
 dk24-20020a170906f0d800b00a43d4730685mr2747782ejb.38.1710274910654; Tue, 12
 Mar 2024 13:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner> <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner> <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
 <20240312-pflug-sandalen-0675311c1ec5@brauner>
In-Reply-To: <20240312-pflug-sandalen-0675311c1ec5@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 13:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
Message-ID: <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 13:09, Christian Brauner <brauner@kernel.org> wrote:
>
> It's used to compare pidfs and someone actually already sent a pull
> request for this to another project iirc. So it'd be good to keep that
> property.

Hmm. If people really do care, I guess we should spend the effort on
making those things unique.

> But if your point is that we don't care about this for 32bit then I do
> agree. We could do away with the checks completely and just accept the
> truncation for 32bit. If that's your point feel free to just remove the
> 32bit handling in the patch and apply it. Let me know. Maybe I
> misunderstood.

I personally don't care about 32-bit any more, but it also feels wrong
to just say that it's ok depending on something on a 64-bit kernel,
but not a 32-bit one.

So let's go with your patch. It's not like it's a problem to spend the
(very little) extra effort to do a 64-bit inode number.

             Linus

