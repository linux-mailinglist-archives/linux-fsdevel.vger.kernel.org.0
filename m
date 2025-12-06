Return-Path: <linux-fsdevel+bounces-70920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC17CA9BAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 01:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76C04317B37B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 00:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F62750ED;
	Sat,  6 Dec 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hZ2szFxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C32274B26
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980275; cv=none; b=Y1E2E5jCWiVKCqo4C2Innp/vfvloQMBMzWAaFuxd5n7IcJnW4DjD5v2ycPIKkB9gKz/4ctOBb6CKsnPUxK3p15OjshiU1t+UQsnbXVfD7sKNZJFqfBqnVsPlCemwWmkJniGi9QCz30kZlDMllXtlcspI6m1h9ontXhpoloPiJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980275; c=relaxed/simple;
	bh=zi+JElV2lv6awvtU6T+r4FeBqKLEdU6iohJZX+fpvj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c68iSgwUJUwziOU+lBxmkzlC+WJxC+MWQO8UBH2i6QSOxkXyQ3FPCiZpXGFpGoBpfCLgsYKe68uWtPAHrfr0oxJEDzaAdd0cwIgkUbgUjVvZ+L9N8XlvAFgus5A65NdkU09d/aSGGLgnJC1RVRg93lSHJlmEnRc/E5AWWCW6zgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hZ2szFxt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7370698a8eso357801066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 16:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764980270; x=1765585070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GAdCWKRjKBbco9Z21VMuvGUphU9wurvv1DCvBIdt4k=;
        b=hZ2szFxtBw/ubeoIE135XRE+Nsvp4jTiWb2QGm/Su4g1od/pfeZfxSEYaT5SSczzKu
         ft6G/7bUfSn06ex8yWn7R5U65y/A+WzpkS0RbSmUOLqCdMEn9MRLJse1WDnaQ+J0c9Gw
         qd1z4kudpLUj3yT0DKS6oKVl3rb1bLz9KMV1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980270; x=1765585070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GAdCWKRjKBbco9Z21VMuvGUphU9wurvv1DCvBIdt4k=;
        b=CwjufPp0EX3p9YlP3agS+PJObD/w9z5VR58Rty7FoNLVGvD5/Gmwsz3HqoyzOZF1M+
         2wyJJINbQXFq3l1NmW6FrpgbP43F875zoalCxyqMeU17eEUPoMXJVXZXzRWqIARDaSAo
         xk6nDwO+N3UMpgA5HS3hkoWc+bBfUhvG4yNebkhEE/EiIJMxoNwOSVFZyNyQPtvk54Ry
         m54MqZ8qaQifKBg2TSpAdF3wISIZla8iasgkgXg6w58A1KBSRQWKn0hPfVgRsUVezSB5
         PnImZDhxa8x6VeYl0WIAunqgkCIznBnvjfFkwY6qj2+ORWc0mdrvGSMHq3rG57uYyIcm
         EJCw==
X-Gm-Message-State: AOJu0Yw/t3S7skllhPyF2WOpkob/f+WVroYSrcHO1K6+oWaXvm1Ot9cM
	zx0xyGKH2JEB+6fA/pc9j47pSFvDJYtl+6acN475wPWQzA7EMf+7mu7638ZsCqE4ztTYeiVDOi0
	gCbsFVhaEuQ==
X-Gm-Gg: ASbGncvEx5LKvGng4Op0ku9oPGqsdqXONeVqA3k8NAiKD5BhuoAljEci3QQISBr7d6G
	hZAxHg5RTfP57WA5fTqwrbs/fqc5h3UY2L2kiwtoEEo4cV8rBNltfnIVehkXUq60z+alJ7Y1O1o
	X6NC0jmj2DYXBqN+RPG/nsub9UViobmggX6vj0jj87RH0UOGUeBMGmOihZ5S6hHR3YrIm2pUv1P
	GXgDRKgGVeFeC3MzUJ7Qfh3y4KjLN/PZxXRZrpPGEElGm7p5tyR7lJDkQ4TUcEOxJ3WCm/+KZ7V
	7iebxEnFzx9NJq49CLNAXX3e47gxQB0YdYaJB3WteK1h3tQBN7RmKSlCekz1oasV6xgBWIJ1wYZ
	mCp708wh63ALnLKdCYQ5M+cEevUcRuwoId7EFD70E7WYNF3LSjUa8ge1mI6vR9cw6Nlp2EUJd+w
	V9h5Oue0xhQRBkURhEP71Sxd2iOgXMQImnvBJ5KDvNaSZKJ06xTV94ge2+Wpvb
X-Google-Smtp-Source: AGHT+IH3Ij6NPfWLkOodiYJIASZIZUhJuMOnBOixme/TV+kggtjEXnfP/FST3VIw2eu0pX/3rXFFfw==
X-Received: by 2002:a17:907:7291:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b7a247aba82mr91674066b.49.1764980270248;
        Fri, 05 Dec 2025 16:17:50 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4a53b39sm494874366b.67.2025.12.05.16.17.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 16:17:49 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso4635651a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 16:17:49 -0800 (PST)
X-Received: by 2002:a05:6402:254f:b0:63c:334c:fbc7 with SMTP id
 4fb4d7f45d1cf-6491a4330ebmr539523a12.19.1764980269280; Fri, 05 Dec 2025
 16:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-vfs-fixes-23ea52006d69@brauner>
In-Reply-To: <20251205-vfs-fixes-23ea52006d69@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 16:17:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjRQDCU9MgH68ubunKdj41iY4V9AJ69zX19-JF+tkBysw@mail.gmail.com>
X-Gm-Features: AQt7F2oczjKtwLKmP3ggu8fkP1XgWQSYtzCZcHG68W53PhIIAMJfrhBzoVC4DO8
Message-ID: <CAHk-=wjRQDCU9MgH68ubunKdj41iY4V9AJ69zX19-JF+tkBysw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 05:36, Christian Brauner <brauner@kernel.org> wrote:
>
> - There's an overlayfs fix waiting as well but it's waiting for testing
>   confirmation from the reporter.

I took that patch too, since it got a tested-by Ondrej response,

            Linus

