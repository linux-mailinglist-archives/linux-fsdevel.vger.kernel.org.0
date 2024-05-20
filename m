Return-Path: <linux-fsdevel+bounces-19829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9958CA2A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC4B1F220E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C9137916;
	Mon, 20 May 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YpNgXxt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8951E50B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232568; cv=none; b=vGtIJfvMjiiA7cW3i6h5ol173KzO1gka+butWoVr8ebnY7SRRGBbv0JCM3J3jhPM0Z5gUavCjopFBXzf4X5jnDRgIAX+e4zzhb3aZDvUEp/vSdeO+ahoyc3BXiiLbT9p+P+z9Udjw+QI+DVfaKeXTsfiEDsZYm2G4LR5ndde8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232568; c=relaxed/simple;
	bh=am9u1eaLSO3aSauXxoMDKEYYgovThj9rArG1s1A/pFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnNf2E45sZM5LDtfaolbveADvfKei5VBgROKOHm58xmNc5u8e44GhA4rRRrQq2TH4YpFF2Otctji5gCRBu7MZsSa4e8aMy3rnSjuakhk63/X4AcnUqyQTvJjFM3lf9/OfS1X1dHz2y0CY9BXnOIv4igUV2etqVMcC7SOckCwP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YpNgXxt9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so31493071fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716232565; x=1716837365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjH5iZLI8vPvy1/UIw5FKExe8077SOb+cb7LYS9cHpQ=;
        b=YpNgXxt9rI9o9+Erv110Hgxt26PlipfzdKNMdAYNs1wCg/NbcfQjnPdWePwu/4zHVw
         LiOJsNqZLdyGj1Yc3jaTUUhudVLuJ0n92MBv24CcOB0QvftoH4jNzdgB8tFQd2WWzkCc
         VUEXev/bUjIfjrCbFpYHH+nJsHVQwPekUEdoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232565; x=1716837365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjH5iZLI8vPvy1/UIw5FKExe8077SOb+cb7LYS9cHpQ=;
        b=YaBu22a4QjqWcEI5h0kbMKKIGHtHV7W6UCag9AJ192f3Ze0WMcqntu4Bqs2nCGZxRt
         4aLBekQY1uECHEg+IW4wNUhFE35f+Y1fEtgLBLydwje9XZwkyPJsEEhKiFclDwnggfPP
         jm2y0Gq5ovfpHzvb7jSGt8cZExs1/Hd+4517tls02atZY2ZmepKhDnzkPJllpC1l9qab
         fnnATMhrHtGIHU0GsSbMIv391k2JxQiEw08OCr4h+1235wwzfDYwDdx2n/sOHn5HZQlz
         m87fqiSxEGsoKAO3n1iUy8C0HxzkSLeKPKpHSA+TJ3TJYW2uOxD0r63SLYUR3dj7o4LL
         ZrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtZD/VCXGjlKoASaYHKu7CqyUK6z4Nhh9h69Pt15fIbgd+8BfW1jOcMRrhQX2VbJbghjIuMSx1SJt1IExl7y8CKuYQ7rs/b05Lh5oIRw==
X-Gm-Message-State: AOJu0YzOTZxaSKRvddC0lqEoxymw0rul0UvYeUOQJ0HxKiMmpeFZ7iIw
	/m60Fq3AxTZBnvy+RgDpYBl8sLl4dCP0lrqrcDpCqfwMmb9cDOx44CLPqnvsk/4/y/+628nu6lK
	Rn/2fcg==
X-Google-Smtp-Source: AGHT+IGmgW7TYhQog0y0t5ax++Yg4LmzPTDzTw6Yq0lvBkXTmkODz3RYU/PuGBMfJwjNITBdRIBQSw==
X-Received: by 2002:a2e:8054:0:b0:2e7:19ba:b84e with SMTP id 38308e7fff4ca-2e719bab928mr40693641fa.20.1716232564584;
        Mon, 20 May 2024 12:16:04 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574e5340d12sm8774792a12.3.2024.05.20.12.16.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 12:16:03 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a599c55055dso738583266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:16:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwJQHcIknN9R2X0NTfDS8ZdhjTk66dTQ8XdgGWgmAzywj/hUFyIvaA+IgQWFn8J98+ZhSrt+NqzjYwbFp5+wmKPbHI3gk5EA+Zke+zeA==
X-Received: by 2002:a17:907:2d86:b0:a5a:423:a69f with SMTP id
 a640c23a62f3a-a5a2d53b9bemr2304418966b.9.1716232563459; Mon, 20 May 2024
 12:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner> <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org> <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
 <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org> <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
In-Reply-To: <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 May 2024 12:15:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
Message-ID: <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 12:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So how about just a patch like this?  It doesn't do anything
> *internally* to the inodes, but it fixes up what we expose to user
> level to make it look like lsof expects.

Note that the historical dname for those pidfs files was
"anon_inode:[pidfd]", and that patch still kept the inode number in
there, so now it's "anon_inode:[pidfd-XYZ]", but I think lsof is still
happy with that.

Somebody should check.

I also wrote some kind of tentative commit log for this:

    fs/pidfs: make 'lsof' happy with our inode changes

    pidfs started using much saner inodes in commit b28ddcc32d8f ("pidfs:
    convert to path_from_stashed() helper"), but that exposed the fact that
    lsof had some knowledge of just how odd our old anon_inode usage was.

    For example, legacy anon_inodes hadn't even initialized the inode type
    in the inode mode, so everything had a type of zero.

    So sane tools like 'stat' would report these files as "weird file", but
    'lsof' instead used that (together with the name of the link in proc) to
    notice that it's an anonymous inode, and used it to detect pidfd files.

    Let's keep our internal new sane inode model, but mask the file type
    bits at 'stat()' time in the getattr() function we already have, and by
    making the dentry name match what lsof expects too.

    This keeps our internal models sane, but should make user space see the
    same old odd behavior.

    Reported-by: Jiri Slaby <jirislaby@kernel.org>
    Link: https://lore.kernel.org/all/a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org/
    Link: https://github.com/lsof-org/lsof/issues/317
    Cc: Christian Brauner <brauner@kernel.org>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
    Cc: Seth Forshee <sforshee@kernel.org>
    Cc: Tycho Andersen <tycho@tycho.pizza>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

but I haven't actually committed it to my main tree, since I'd hope to
get Ack's for it (and testing).

Or does somebody have any other ideas? I think that patch is fairly
clean, even if the *reason* for the patch is odd as heck.

           Linus

