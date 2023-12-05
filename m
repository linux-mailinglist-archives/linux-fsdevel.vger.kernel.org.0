Return-Path: <linux-fsdevel+bounces-4896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77298061D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140B81C20972
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701FA3FB18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qyf8U6CM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3266A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 13:25:28 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a8fb9d112so21377076d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811528; x=1702416328; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybenO6JKKRDn6ftSruJGndBQsEtDe1upMJA2JO+7HT4=;
        b=Qyf8U6CMRJ2VOaNQKCe6e9hnEskS49HNekAAEkfKBfje0xcXvlPTjAR/IsZJgsWDJA
         fyrIIDSvQ6zD8rkd7BQL1tcvpPSn/UJxtZvcbFz/BlpeYKa2/goXkNb5O1Zkf9DRlkA+
         11LgiUjFJNIvodNBtE17IJ78im3e5unPlEYo/D8oxtV22gt8C8IbWJJE+ViN1aLxyXZG
         2AThNTHDjymkQtV7g5MzVA5kdREFW2gbT00HpXCaDGm8nK1QwSy59Jo0ZKpI0PgzDNJj
         NxjkBf35jNPkNaRrqNGLYUatHFrHTDqaPbxGuU2+14NnAaBWHkQvpZrNulGFITjjVNQ2
         IicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811528; x=1702416328;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybenO6JKKRDn6ftSruJGndBQsEtDe1upMJA2JO+7HT4=;
        b=GT0UaMbVuQYWNpEtDHdzwTFBzGYfywGh3p+KZSIcRA76V98jrBGXygpgZoIGhgo586
         xor1Anoo7Cpu4zJGN+z3Tbi6RGUERVNbS3DqV4DQ+AtTrt4WrgUuG5CpFXCLbmsWGMQc
         gFh1mSxjC2z798Mrg5b4H5boufmHjB6zr7xG7Is49/1h6seQuFggMs4mjOJBBe5KfShm
         dXQ1BKAOjEE7EfVPAbjoWTSh0zbY8/YcbBOmvAMbxzaAcxfqq2oV8UfsCnkJmuXrJtgJ
         non+ufwnq964kKfz4qCQsg8Sn7uYWKDI2dL2MNp+rC/p4q5kCtqOu99hhFsPXkFghDZT
         1ttA==
X-Gm-Message-State: AOJu0YyzqaMZDnuW8HRvg9xEuXoErzkWXXhb4EiqNkOiyjk8nNet1Up2
	OsMV7ROQUATGvKULUIvNhCPN
X-Google-Smtp-Source: AGHT+IEVTa0Sf9/RsSghdfc3Hbu4qPY84/gjX8Nyb16BAKIZBRdfJ20XSDr5Bo6Wx1zoYLWQH3+ZIA==
X-Received: by 2002:a0c:e84a:0:b0:67a:dadc:db3e with SMTP id l10-20020a0ce84a000000b0067adadcdb3emr1665894qvo.33.1701811527751;
        Tue, 05 Dec 2023 13:25:27 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g3-20020a0ce4c3000000b0067ab7eada1dsm2719307qvm.59.2023.12.05.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:25:27 -0800 (PST)
Date: Tue, 05 Dec 2023 16:25:26 -0500
Message-ID: <f3f08ce6b3b273bde1ce6eb41b0ca3c0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, linux-unionfs@vger.kernel.org, "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: Re: [PATCH 3/16] capability: rename cpu_vfs_cap_data to vfs_caps
References: <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov 29, 2023 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org> wrote:
> 
> vfs_caps is a more generic name which is better suited to the broader
> use this struct will see in subsequent commits.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/capability.h | 4 ++--
>  kernel/auditsc.c           | 4 ++--
>  security/commoncap.c       | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)

Bonus points in that the proposed name is shorter too :)

Technically you'll want to get Serge's ACK as he's the capabilities
maintainer, but with my LSM hat on this looks okay, and is pretty
trivial anyway.

Acked-by: Paul Moore <paul@paul-moore.com> (Audit,LSM)

--
paul-moore.com

