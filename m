Return-Path: <linux-fsdevel+bounces-48672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F3AB240D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E5F17F0E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E08225761;
	Sat, 10 May 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qep+7m68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337C29A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 May 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746885483; cv=none; b=mLcSiwQjI+lXMfPkRMSB/4zAPlD8/oMSuL/yZ9cLTprcX6/Uzj/lsZfx3Whw9KBz6KzIulzx5CiyURN2Gc8CDA14HHBGVGp9CACT7wRmFqmxjBYuxw4gCu0bx11GDIjfwUkpHQ2efEutnsUhJsX4KMtSN4PppnMYVrrInD3ZjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746885483; c=relaxed/simple;
	bh=uX3M+MdQZdkfpLfXG+7hL40wEi14OpO6k+li8zz5AjU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jFVxQCUYvzDY/4rxGz0uMBsk8CwSXsVbVUUemIbPkH8Qwx0Enw8mzv9suedjoxUFkiAG5aqzylj2fdH2agTQHjzgJjmk35nGbsBvobJxPSkyTG28GahbDZT3WW3bdZTvKP5FKPnzOVPYV8ozPGqYVC3sGoG+Kh95d6UcjURX51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qep+7m68; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so4839805a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 May 2025 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746885479; x=1747490279; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emQfG5Ubuvnd7dkQ+F0CepSc7aG5lifcbnmHtdFt55c=;
        b=Qep+7m68aa8fcJu+MrcuQTBQxjKqSvjtljorgRG2W5qlzUI1a5eZQ6xtJTsoe4RuEB
         xB5ul5z2p8dmKZvOaBvQ4FcwICuy+0Ni6K4djOjEULt/EB+3hfQDM9JcAB1nrDAJqrH9
         a8rFBPnF63InDwKmr3eU5xdb1bMA0gx3Oepd+unrNo+NhYUj33ojo06e5+/PtcHyYVNQ
         mt5d4EQWm7dS/b6Tb0jTlU5YXboKy636UMY8jy6YI0WRMKJrh1G6z2K8bYH0AWKVAUPC
         WVYMxNejrpsdzQAXLnidx7SFGgDrxdomV5piVti29A0u4mEHDc6VzKFIf6LfF48BNLZ/
         qlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746885479; x=1747490279;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emQfG5Ubuvnd7dkQ+F0CepSc7aG5lifcbnmHtdFt55c=;
        b=aUe1Qg4F0ciXcO+y0nhG0kKuBP04HrKa95GXiyWuWK+kaUGiEoBNgwtqkdA2M+tz3L
         nVRYHukQo1KbXms9GUe3KK9dLskdy8AWwn1H2ipUpkSODhTbWncMlGXLoNgdRL4eSVrk
         ki64lBmHB0Pt0J8zHGlatjVAsemvgLjUiFbdJy6odGBMQNoOCN4JCf3cYom62S32x0TL
         WddLOtzPhPBj6PUJRBsdDxzJ2T17MP5g6Kct+hdZkw9spkQyZLJUpi8v05GdoJvbY52y
         K4OgE8EawIKeMl4z2jtTZvzhT+oj4qs+mz2af51RYBz2ZnJukgYUUnRUa6+D8/NLHr0g
         BNiw==
X-Gm-Message-State: AOJu0YyqfiUtiXeS8AUuZs2eXHd8UElVkNI8GuB3gONwkWUPCqxqksy3
	UFCd/5vVW6JgbBVfeeYCA8514KrGyx625EeNTKF0DkUJYM0i9nzaWIT5AfHEa5PmqSVC2bNF5oI
	/kxaU6scDUmkuEWjVTXWPrTtDw5WsMl0+m7Y=
X-Gm-Gg: ASbGncv8UI6Z3WE2BQpfRTG3HUjV1AwSWFpXryMtxUjq+JH/g6P7iBJuRgu30BOe4rG
	d/WGfywS7xTfRYyDLzIRqVfabrCXQfMaVf3c79Goxjq+lKxDdzHOLXzoGiV5aWtZvGBcfHfXbH2
	rMLnIICA3ITwGu/tx0eYfvUeNyqP00SMxhKv0SMxIH44tln/a4phSrMP7gPNzOpV9iWGx701WW8
	f0=
X-Google-Smtp-Source: AGHT+IEc1xxAYKzwmEgx8v71xfrjhm569ehAdqcYEGINauoU+EBHNnRplTNBuxDpUo8SD1DnGLVzpHw5n+ZXmx9ucAM=
X-Received: by 2002:a05:6402:1e8e:b0:5fc:8d86:cc0d with SMTP id
 4fb4d7f45d1cf-5fca081c374mr5751803a12.34.1746885478707; Sat, 10 May 2025
 06:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date: Sat, 10 May 2025 15:57:47 +0200
X-Gm-Features: AX0GCFsb0l5IKdiVo4rsoPjLh5nwPSuSTWV3KnzwvVXzR44nIu1H8HQhzVjeWlE
Message-ID: <CAB1LBmuNcgeFfEsqUW=hR5x=Q_96ox2wnpZXevxyy9PgdyhbQw@mail.gmail.com>
Subject: Increase NAME_MAX to 512 bytes (and maybe also PATH_MAX)
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I hope this is the good mailing list to ask for this.
(
I asked first where I should ask on linux-newbie,
but linux-newbie mailing list appears to be deprecated :
https://lore.kernel.org/linux-newbie/CAB1LBmsr0AKUAN+gChbLCWB36Dt81F3vtMEnGfK6e9oxYHL7-w@mail.gmail.com
https://lore.kernel.org/linux-newbie/
)
NAME_MAX is 256 and hasn't changed since the 1990s and ext2 filesystem.
PATH_MAX is 4096 and hasn't changed since the beginning of the 2000s.
No change of value occurred for both since the first git commit.
Whilst PATH_MAX in Linux can be circumvented easily
NAME_MAX is a hard limit.
See:
- https://unix.stackexchange.com/questions/721339/what-would-happen-if-i-change-path-max-and-name-max-in-limits-h
- https://savannah.gnu.org/bugs/?67014

However, it is easy to find legal webpages
(from official French government websites for example)
whose title and hence filename upon save is above 256 bytes.
It sometimes makes some bugs more frequent/visible.
See:
- https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000051445248?datePubli=10%2F04%2F2025&nature=DECISION
- https://bugzilla.mozilla.org/show_bug.cgi?id=1959738

My focus on increasing NAME_MAX came from wanting to help my mother.
I helped her switch from Windows to Ubuntu
and long paths and filenames were a problem during the migration.
I know some people may say "Nobody ever ask for this.",
or even "Since it didn't change for so long, we can safely assume it
should never change."
but we, informaticiens, know how to use short codes to shorten files
and folders names.
(I use informaticiens French word since it is common to
computer scientists, software engineers/developers, hardware engineers, etc.)
The people who would naturally ask for this don't know how to find
this mailing list in the first place.
I know this is not easy stuff, it probably needs some new filesystems,
but I think there is a real need for some people.

I asked first about this on Ubuntu,
but the discussion went off-topic :
https://discourse.ubuntu.com/t/increasing-path-max-to-8092-and-name-max-to-512/58748/29
I hope I will encounter here at least one pair of ears interested in
my arguments.
Otherwise, sorry for your time.

Best regards,
    Laurent Lyaudet

