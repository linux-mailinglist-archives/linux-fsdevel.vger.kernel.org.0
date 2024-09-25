Return-Path: <linux-fsdevel+bounces-30117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF7986516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71F21F25EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC75336B;
	Wed, 25 Sep 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1ruB+AV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F83D982;
	Wed, 25 Sep 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282697; cv=none; b=mR4YKM8UwAja53dK07YzM/9X7D/My3KMGZesn/NVJHQG7BFTrGb5nUVnLu9Ro3m/n9UL83ydBTgafowcbYJoONLqhGi+hdw1CqsYGcrXQJYAaXktZYMKw69oRhrqIMxYIIf4e22CollkWOWoAjEaTKW2xi5VIp+U7/jlXqlo5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282697; c=relaxed/simple;
	bh=e4mIbPeUi4IIJOjjjTHV7QDYIBnrUl904pw7QZo72Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eCaJEo4+pnuNb0T6DwzONLNSpb4RpP9pV7ZABB109FXHkiNQIBQAGWLqsOyPzxAh1IC5QkrWauqOcb+Vz7UU8gcJwxxjZ1syq8wUIElsRyfEe5we7VDa5DFSAx1ZpeVwHJbOuPje4MQbR4ed/egMFfil0j0MJk2d08U9G5Ty8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1ruB+AV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso18228966b.0;
        Wed, 25 Sep 2024 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727282694; x=1727887494; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4mIbPeUi4IIJOjjjTHV7QDYIBnrUl904pw7QZo72Do=;
        b=m1ruB+AVoKzOao9Hy9/n8UgYc+FUunsucla8IiMoYegXXM70pDEF8jiUZ9Y6QKzIAN
         FxBCFS/lyskFfNZdMYeQtEv5ADbc8PiNSmMxn0R2FsGhxsqcFqxTlLvKa7zPRboaxUDL
         iVABgZA2cr+OnWnjxcRAfAgG4V8+AduPegIss7ib/KD8XQlhEUOaQZElNXdzVROUjdT7
         QjGWK8o6ShOSTb9jlqbjqSsb85jXLvxKhzLc1b7aLn7rImhgFYoGH/ape/KpGj0y/m2l
         VWaDcCqlJkNcU1UOJLfqN00hLr2GDdRpeITwqEd++TuMqAIdrnp5ejPh68smaxDQu6Cm
         fFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282694; x=1727887494;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4mIbPeUi4IIJOjjjTHV7QDYIBnrUl904pw7QZo72Do=;
        b=Zp7uq3pmxd8piIOY5QXGc6xb1pYFYy6wtjMqNkPY6ASVqjjBW3QSSQ+IUcKO+hbPal
         j9WyQZQa7FRBkZ6F0pYkH1TfnGcLz0IwT5hg1a8zIyZMbvesAIxeYRd+klimmnPhuGUa
         N3dubz7fMh6aysEUNs7r9QNsUI0DZSAHIg/RNnmwtHVdNZWtWWsjbHruGx73UYfIgjA/
         zC+QrAWkhRK4FGLIO5Vbb09dshq53Igy0n24RP/ys0rfioi+rL8gFpjLko//d2J4xlE3
         4wDhfuBvBl3lEtqDS140NrFATsfbAIzyP+pTwgxqev7UXZPQ+Er8nuTONdi+lWaVTO0V
         mi2A==
X-Forwarded-Encrypted: i=1; AJvYcCU4fflq5tTwMelpxgmtRxebKTFLCFft2awU0m7GTI58BYoMhOihUCzFoWWdG1SJa0osid/DhUL2b5Kuw9/V@vger.kernel.org, AJvYcCWYBIrPbSmVgrDZu3X/FeSnUOBv2xpi852Ov3tCIbEB4wvJawhN1c5PvnuDJvyL75F7iv37ahFixygEeDbB@vger.kernel.org
X-Gm-Message-State: AOJu0YzIU4kyC/qgxzOKCcZy4z7jQ091yuXCivq+wQbLvNbGAVOfBMXi
	Bw0/GllkceSGKaLhpA3ILY+qW7iUEI4zFUldQEiA26OnQxv8oRSrMwm7ZOI=
X-Google-Smtp-Source: AGHT+IG9D0LDfzS3VIl5vBz7iU9wg9X0r6ayH9AnEK8ZPj9L0m8niTNMc6lMyYGHiic4SRAbk1HcFQ==
X-Received: by 2002:a17:907:f1aa:b0:a8d:4e69:4030 with SMTP id a640c23a62f3a-a93b15f929cmr31248766b.19.1727282694305;
        Wed, 25 Sep 2024 09:44:54 -0700 (PDT)
Received: from p183 ([46.53.252.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f36369sm228320066b.42.2024.09.25.09.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:44:54 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:44:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <d559c6d7-5f69-4e86-8616-11d1718ae782@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> #define AT_EXEC_REASONABLE_COMM 0x200

Please call this AT_ARGV0_COMM or something like that. "Reasonable" is quite
meaningless word by itself.

