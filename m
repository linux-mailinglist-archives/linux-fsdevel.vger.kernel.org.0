Return-Path: <linux-fsdevel+bounces-10394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A138784AA75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE48CB256C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A54D9E4;
	Mon,  5 Feb 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="bYfrFmkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92644D5A3
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175469; cv=none; b=WPYVYMLllEbhbkGeePR113uDF7JKasTY/LQyATkh2G/3+nQrq6chiEuhiMMi7Lv/2sMhRi35j5Xbm4alI7FjFIm/FS0RQUjrkL2I1+dH98VuzymZLTETGM53WMgGeo1zaRo9Rfjz36s78HQXd87P4i8qbgol7p+ebI0iB3Ua+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175469; c=relaxed/simple;
	bh=9NGjjARXFNOTt3fgpF+1IhCFiMpjWh/egnV5kuc837o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Vq92jVtr8qM54Onkh1adKGL50PIGWmnvnjtWNcJJqyXsi3Rtze91VfDUcL4QhyTwKci9qTvfNqVnFLCNm/L8X7yzEkvSWwDXzIUkj6pzeGn4BEG6Iv4t2iaFOeFGaDwp7IW/y6Ag7cKuflDqPAapNdQv4s9xbs6NT2Nww3ze0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me; spf=pass smtp.mailfrom=sargun.me; dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b=bYfrFmkU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sargun.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sargun.me
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26fa294e56so30855266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1707175464; x=1707780264; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9NGjjARXFNOTt3fgpF+1IhCFiMpjWh/egnV5kuc837o=;
        b=bYfrFmkUVDPKH7o2/TzLcuTLfnQiXRVat3+12viAvehjgFV73xdYyYWyiBXEUJqE7G
         GVo6q76N51RRHcb1pjPJ75/pzYjksZmwf5iTBxhXRTu+7MVlt9+AL5huZnTcoS5shmwi
         KnwNxNf4AmgbCN84xzDtcZXqRkSAXTzIVefqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175464; x=1707780264;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NGjjARXFNOTt3fgpF+1IhCFiMpjWh/egnV5kuc837o=;
        b=Vtv74HcUO+DGsO4NLXqPZzc3zIpT8EM2725hr5p2e46pyRqDEZUC0lCBaCnCME8DOt
         AJESARvSqv7flbKOTxM5LgMkiu3z7Lbzfeg6yD2GeeGv2Lv1qP2sY5koaBbz11q9LU4g
         ot/08kmo0Z/o/OAz4mc2AvC0O7e60H/7x1zQIhjsAmxfsv0hUnSB5yyDLS+cZy4vLv7w
         VDMwx1TAQS00Lt+p5LbsRtdFKTaX3LbP398fEMyziAxztzV8iGQIY2PodwbhtQKFTc7P
         jebiqPrEeYvflpEGeF2QS5qUAdboy7kHEz/R30qHI819gylfDeL6ScG4Ju+g3Kupp0vr
         +GpA==
X-Gm-Message-State: AOJu0YxGsvk5tpq84NWcOqaPFg6B1pjKwJTPNUkluNd8MbVbZOKdDjKz
	ofLxg5e9jc2cUuvPbtU4wK/ezRV6KQ6mWw0S3n7kqxQw9VJuzqwNkzl7PK9Spdy51b5VBmjeyEa
	zeJx0x9OIjoKZe3MUDJJ7Nl9G8Ik0eD9lXipaw7su9Yq5DVSEYwI=
X-Google-Smtp-Source: AGHT+IERWVySBTxBx/QjZAjLAa2SyKHK3VUnd85ErDBveyr9fSJPfRc3xyl2C8sc/A0Mqe2U/DC9DkM1ATRG6cWh2xA=
X-Received: by 2002:a17:906:53c8:b0:a38:1e54:91d7 with SMTP id
 p8-20020a17090653c800b00a381e5491d7mr77657ejo.56.1707175464197; Mon, 05 Feb
 2024 15:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sargun Dhillon <sargun@sargun.me>
Date: Mon, 5 Feb 2024 18:23:47 -0500
Message-ID: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
Subject: Fanotify: concurrent work and handling files being executed
To: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Sweet Tea Dorminy <thesweettea@meta.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

One of the issues we've hit recently while using fanotify in an HSM is
racing with files that are opened for execution.

There is a race that can result in ETXTBUSY.
Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
Pid 2: execve(file_by_path)
Pid 1: gets notification, with file.fd
Pid 2: blocked, waiting for notification to resolve
Pid 1: Does work with FD (populates the file)
Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowing the event.
Pid 2: continues, and falls through to deny_write_access (and fails)
Pid 1: closes fd

Pid 1 can close the FD before responding, but this can result in a
race if fanotify is being handled in a multi-threaded
manner.

I.e. if there are two threads operating on the same fanotify group,
and an event's FD has been closed, that can be reused
by another event. This is largely not a problem because the
outstanding events are added in a FIFO manner to the outstanding
event list, and as long as the earlier event is closed and responded
to without interruption, it should be okay, but it's difficult
to guarantee that this happens, unless event responses are serialized
in some fashion, with strict ordering between
responses.

There are a couple of ways I see around this:
1. Have a flag in the fanotify response that's like FAN_CLOSE_FD,
where fanotify_write closes the fd when
it processes the response.
2. Make the response identifier separate from the FD. This can either
be an IDR / xarray, or a 64-bit always
incrementing number. The benefit of using an xarray is that responses
can than be handled in O(1) speed
whereas the current implementation is O(n) in relationship to the
number of outstanding events.

This can be implemented by adding an additional piece of response
metadata, and then that becomes the
key vs. fd on response.
---

An aside, ETXTBUSY / i_writecount is a real bummer. We want to be able
to populate file content lazily,
and I realize there are many steps between removing the write lock,
and being able to do this, but given
that you can achieve this with FUSE, NFS, EROFS / cachefilesd, it
feels somewhat arbitrary to continue
to have this in place for executable files only.

