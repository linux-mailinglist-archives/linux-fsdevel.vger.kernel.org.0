Return-Path: <linux-fsdevel+bounces-10587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9A84C809
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65704282682
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B623761;
	Wed,  7 Feb 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F2LU3Stv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FA23757
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299690; cv=none; b=cWzxFdFNBYVjElgvwb8qjFW6mmaWQ9cafMMit2GFqLpV6T2P4Urh/SzAr5as8Zg3DtxDyX9APRuL7xcvi8Sjvj/yFFZtc6f1jSK2VheRBXebYoQ1WqLolBHha9raZ41RFq8itVbBw9tIbpxIArgbzFjYoMuIVTVrCS9aJQvFpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299690; c=relaxed/simple;
	bh=gsrPl8ONKkHgMXOtQ3LNXnXN90QVWA2iAnCCffMCo5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TSoK6ezX08f7PkTrJ6D8hkgRAEeIEOZtifrLFt4fZHMosJgBoyLVRnwne9WMuzkg7sYpv0lVwN2xbu2aNQF9xrwE9Z1T5E9VGZ0MrwVdw0TxCqsSdlic6l8KxwMdTJPT5LH8Wp7OGZgExs3VNQoDLGZoQCHntzC7zqhUxmC3td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F2LU3Stv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30e445602cso317801066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 01:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707299686; x=1707904486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RHDGnGm44fhHZ7pCs6HugzuCEaAY8Qf8wWUN/+3rMqg=;
        b=F2LU3StvfmH1V+ZOy2mP9Iq5/af1AmYpZG23lOkgKdrDhktZaxdwIfiWlel/wI9PQ+
         nGue4OMcADC0FmywqHfmyM9YhIgy2f+9N8otehqYZtRy0OrXjBCkcVCCp5BfEn5SF0SH
         f846C1jbC0pWLCKqIgGee+lLhbZ5FSlOdQplg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299686; x=1707904486;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHDGnGm44fhHZ7pCs6HugzuCEaAY8Qf8wWUN/+3rMqg=;
        b=wUmKh9fA8VZ/w/kLn5toO+VwjNfcuGEe5AvtjweJY5yJ7vr4wI0ONfFLEU6Z3SSXO+
         256Ygzb04N7Jz4dK/TOIHJy3lN9dKfoAG4raRKwUzlwASiY4fYtmX/YcOpfsX8w6xIbf
         tNNQGdyIv+4Svu7HXvZ5hpKu6fAyMFNydzvEfivdZwUzNeVW67NPWFu1Uy+4lg6t98XO
         fjSwvuvurNsfQHvpCqiIuInC0I8LD4KZGbdi2aCr2kCRce9/S6v+VFkI2PdEdzLzyBtC
         eGAk+fXZxv2n0fJJQ87m4ZCrdGfDPqYtkZJSpi4DMtIPTskZ0ljJifcdDNxroxmawPtj
         MCRw==
X-Gm-Message-State: AOJu0YwjeSlJoPYU2zPw3Cp74/HFCSS5mxA3uV8BviuIlBi0KIy/qm5M
	qTyKzBr5TDa10EnhWb7T4zUhOkF4Vt7dgzFNfkClSJTLFQ3T3yJAkrMeMQPDNMcXlB55BR2FOEL
	9R2hmfr8D6xkc/CwbE5OD5Q80X6YMZcSpRJPrVAznw8SpirRoPDA=
X-Google-Smtp-Source: AGHT+IF73iv5icu6q3xofIA00A8RhblFD5mtldjebxgQ9NMsDP4GM+4eOq7qYYz289XPnTEvHrKeFaGVIjOPfUuIMzs=
X-Received: by 2002:a17:906:ca58:b0:a38:1712:ef2b with SMTP id
 jx24-20020a170906ca5800b00a381712ef2bmr4496577ejb.21.1707299686008; Wed, 07
 Feb 2024 01:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Feb 2024 10:54:34 +0100
Message-ID: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] tracing the source of errors
To: lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[I'm not planning to attend LSF this year, but I thought this topic
might be of interest to those who will.]

The errno thing is really ancient and yet quite usable.  But when
trying to find out where a particular EINVAL is coming from, that's
often mission impossible.

Would it make sense to add infrastructure to allow tracing the source
of errors?  E.g.

strace --errno-trace ls -l foo
...
statx(AT_FDCWD, "foo", ...) = -1 ENOENT [fs/namei.c:1852]
...

Don't know about others, but this issue comes up quite often for me.

I would implement this with macros that record the place where a
particular error has originated, and some way to query the last one
(which wouldn't be 100% accurate, but good enough I guess).

Thanks,
Miklos

