Return-Path: <linux-fsdevel+bounces-11889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF285866A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 20:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C744D1F24549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E375137C4A;
	Fri, 16 Feb 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhSj6mnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D7433B0
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113200; cv=none; b=Xd7+nLrUym7oErP40G91y3JKt1lkVmqqjVOngGYmWz3C2CDZghDeBW78mzjRk6+UuQCCsnkYAPK/kN/10bhbvaH1K86XE8P12EoE91Fv3ipxGwj6sMaNEKPx/cOff+Axle8mp4n6ESJlWojRvk09ad+TSufJ/D5uRWYSPG4qukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113200; c=relaxed/simple;
	bh=OyttSQJjlrv3AlcIV7LDU8V2PD0Ubsdm+7yx+NWCqY8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k7ft0A3SNoqcuRopw8PeG8ZnXreRYdoWe+/KFCO3epqH0u8llqyXgTcRlITVePgHqVmnYuXBGUVEYN/sNnMQK3d7oUML+80llefztazwDSD9UR46yv58ErY2gZD3REIm9XI5cM3WH7FrZK0RBuGawMFMZKeAT0+35rrhRyMRbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhSj6mnz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42db1baff53so43731cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708113198; x=1708717998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5B/j3G07gJZvOQOVMzAXdEZwYlWaroSaYmmknHh7xdM=;
        b=mhSj6mnz1uIQzBJMT5fjVL5YXuUovCtZO8lONs7aY4pxzFZ/ALeY4B06yv5O5aImt7
         BCfymhxDQZIhzK6IE6S5d/+SWCIlAv+uQMy+5wKcbgJRWI8nIwukfL4jhY9KsQxHzXl+
         niOva/eXSnvwOIWtRTi1h6jY13Nee3UsQMAN9+G+WexIyrtLtUJwozAwuokrC4AdaX1U
         6O55WAs+LeRQyeCi4kRr8h82yMO7GJXJIUerqvJ6vkhRn9WyrCAlpmAZewAo2EqGuRG4
         P8/Lk6yRANymrsFulBWZ9nheANl6S8r3XtV1G2WV9APa1p6g1ZPY7d917jR1IzRgWuAJ
         46kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113198; x=1708717998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5B/j3G07gJZvOQOVMzAXdEZwYlWaroSaYmmknHh7xdM=;
        b=e2z6CgSIajiMSSqbnQykD6lWIgAW0YIO86U/rAEyESkdX2/vSfc8wLtYESsI7NXiJH
         ro8gh7Bt4X7HeyBIF6m8UiZGTa3Oext21cq2tJgNMuZTprXYfCz1Z4LiA15/cL3PU9zg
         E7c+srHqU4oDosGrvSUjOhzYM3rFZdLMBX8CWEZZA/a9MnkGFmJNVkUY0c2oF+zP/j1c
         1PUo9fg93pbLdNkbVvLqjKuUq5eOnkSLMKFg6iuKK3j8XCEbZyhSUUTLJ8Zl232dnpPo
         fZs3qI7xH0838BdU3ThAwDS/M90/jGoV7ks9ZCgpnFT3rJfsCqn98lVPnMmUC2yuUoMZ
         XUjw==
X-Forwarded-Encrypted: i=1; AJvYcCXQh6Mk3xdWUJwUZ/p5GDWn90t5MvM5mNHVzWDmQ4s+bDTj1XIohndPQRNjSHM9t5QctoR/XNf/qJm0d2cpx5CIWcWpcqVvy3fwG4xO/A==
X-Gm-Message-State: AOJu0YyDpmTpRKMIa1H+ObDYdYV0u2LIxGWiRSAkK9q7LtWwUXuuIiiv
	OmzLxp4DbpaY30YrHX4W7p4cBy565u/5opB5LXltFTb3RAB7Grwt889vFZCCdSlhfWqsIEo7fqE
	OSABsmRt9P1PMJ/977RvOu7VY6haH2SfOaWMb
X-Google-Smtp-Source: AGHT+IFCZ0QyDfHSpnEDnApNxB798LSgGfFPzf66h453AgZV5OD63xLTHzQBhwB285VP9CZxKH9l5mH3l+YWR8a+lek=
X-Received: by 2002:ac8:4d8e:0:b0:42d:ec86:6224 with SMTP id
 a14-20020ac84d8e000000b0042dec866224mr31379qtw.15.1708113197866; Fri, 16 Feb
 2024 11:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Lawrence <paullawrence@google.com>
Date: Fri, 16 Feb 2024 11:53:04 -0800
Message-ID: <CAL=UVf5hZNVUPv4WdLsyMw5X8kP-3=gwU9mymWS_3APTVuSacQ@mail.gmail.com>
Subject: Regression: File truncate inotify behavior change
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The change:

fsnotify: move fsnotify_open() hook into do_dentry_open()

has modified notification behavior on creat. Specifically, calling
creat on an existing file used to emit a modify then an open
notification, presumably from the file being truncated first. After
this change, there is no modify. I wrote the following test program:

#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/inotify.h>

const char *dirname = "test";
const char *filename = "test/file";

int main() {
  char buffer[4096];
  int size;
  char *ptr = buffer;

  mkdir(dirname, 0777);
  int nfd = inotify_init();
  inotify_add_watch(nfd, dirname, IN_ALL_EVENTS);
  int fd = creat(filename, 0600);
  write(fd, "hello", 5);
  close(fd);
  size = read(nfd, buffer, sizeof(buffer));

  while(size > 0) {
    struct inotify_event *ie = (struct inotify_event *) ptr;
    printf("%d %u %u %u %s\n", ie->wd, (unsigned) ie->mask, (unsigned)
ie->cookie, (unsigned) ie->len, ie->name);
    ptr += sizeof(*ie) + ie->len;
    size -= sizeof(*ie) + ie->len;
  }

  return 0;
}

which demonstrates the change - if you run it twice without this patch, you get:

debian@debian:~$ ./test
1 256 0 16 file
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file
debian@debian:~$ ./test
1 2 0 16 file
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file

but with this patch you get:

debian@debian:~$ ./test
1 256 0 16 file
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file
debian@debian:~$ ./test
1 32 0 16 file
1 2 0 16 file
1 8 0 16 file

(Android has a CTS test that detected this change in behavior. I am
not aware of any actual breakages caused by it, but it seemed worth
surfacing this change so we can decide the best course of action.)

Paul

