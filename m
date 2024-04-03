Return-Path: <linux-fsdevel+bounces-15948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEEC89615D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0C22885D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB3DDC9;
	Wed,  3 Apr 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9GxVKw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83071870
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104058; cv=none; b=oFAdUM+Y8nmpYfUuZlTDGqDBuMHU7KRe2+iKew1lQIfC5h+Ri6AifJXAHaJiCjd78d4BLR78DpeZjg5ufsjsvV/1tf7hTLsJMOBWtA4XThlo7F8o1PBYdeGCgM4LxeYLWeGQStfqXY8pQC0pPQDYM3WuANsMmWLvGCfbPRzr4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104058; c=relaxed/simple;
	bh=6bx6dvjCDy7W2XrYx7Yjz9n7aSEbbJChVDFrOXZevqA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aGHXqX3EvtnVCqzVN5u4DmrwE0SpDsYBmg3whkmDRZVqyzEeas6t4AAap6mEzRBtMZ5rSW2GXMG0a39gDsbQioixYo8t7MeQpdhcVDkqiyAO0PikpRdAH0kPusafzqsSJen26dQIkPZl+ZCGZFzkKYiYbs18FFUuYNVQ+oVisYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9GxVKw0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso6851197a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 17:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712104055; x=1712708855; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z54Vq/DYl09yFH5y/5HKdIW9f1qPSd6mTVIl2My/z5Y=;
        b=R9GxVKw0N8/e6oe+6SBFGJ91QDoNl6BRCRPYLyUWZmLbw4mmhvOpjByBXHXqdY+6US
         ttwEjNDuMNsspYQPIou3P8r9Jo7f5Q4B4d7eBJ45gsCHoqPn3174yJTcACzl6kedXx22
         4oqS9072iBsHF6pV5GotGC/XmPyP3iGlY8LEGjx8Hk3D7myzUCGpvsI12dXnpdCcrggK
         JHkII+emaGWEX2w6iNElHUUUp6MvHmWmZVAMTl6K4k8dd2FCJtUeuBdWy6W4m4DtSqLw
         v6EIx8YrG5YmFKQpZ8MiPz2nnE8AMRHGTgFR9RJdsgqbpwn67FPZKTzlQLb17PbdIvEK
         14eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712104055; x=1712708855;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z54Vq/DYl09yFH5y/5HKdIW9f1qPSd6mTVIl2My/z5Y=;
        b=RU0l/xM/BeCePunClPHjcq5JjRXGviqN+kpjQb8p8ExP9aOkN+CD0ZjHphvVccdHem
         PIXZ3N6XOYIj03mphH5rC0cZEV3aeYA8iUqFXDtQGXbYtO5bEplITG/DPP7BoKtbw6uC
         MM46tJJUzAy8bhirNl+o8gbsklFdkqgLngK9Q8yyxXCLtrkz5B+Uoh3q6ni/vJ3A+KPJ
         7MLXc3TIxOLkIiDEd3+9eP4LANiuFsvoLztSZVX/q1I+LZATcdDg6BvKFHyYOkv+Q46F
         3mqMTqI7dyePSkFvK+W50mtF5lf9xdU/rULtfKRsjRggxWy54O7KD0/zuDIAvl6Y/Dqf
         2npg==
X-Gm-Message-State: AOJu0YxIuCVqQmDtO7GEujv+IJensQ6J0If7R+/yPtlo4z9IJQSeZ+GA
	1WGtlYx1Fe23WDh85t4hWJdPna29Xv4SqNumYXwHR4gl/wa6CNm51jx3G+2sDbbgKqqyIbO95Cw
	DTOfHV/HDOZDfwi0g4vgIlV7aExDL9fJYJTw=
X-Google-Smtp-Source: AGHT+IEGCwBxb9UDZl+HWzKsJSngYAy65nsEX0LUaluQVsC2SerF2MDDNlIfulT4OgzlV+EKcBr+14cqEPg/8bx/aLk=
X-Received: by 2002:a5d:648b:0:b0:343:53ca:cee1 with SMTP id
 o11-20020a5d648b000000b0034353cacee1mr5517311wri.13.1712104034255; Tue, 02
 Apr 2024 17:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Marshall <joshua.r.marshall.1991@gmail.com>
Date: Tue, 2 Apr 2024 20:27:03 -0400
Message-ID: <CAFkJGRdhJrhb3-k28oX3WkqqDCTw7egQCJhX42-XXxGXbnnc0w@mail.gmail.com>
Subject: Is this a fanotify_init() bug manifesting in fanotify_mark()?
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all, I rarely post.  Please be gentle.

I am making an event driven free space monitoring utility.  The core
idea of the design is to use fanotify to listen for the existence of
events which can increase space consumption, and when this happens
check the remaining free space.  Extra functionality to make this not
face meltingly stupid are planned before I suggest anyone use it,
don't worry.

I am using the documentation here:
https://man7.org/linux/man-pages/man7/fanotify.7.html
https://man7.org/linux/man-pages/man2/fanotify_init.2.html
https://man7.org/linux/man-pages/man2/fanotify_mark.2.html

```Causes problem
  int f_notify = fanotify_init(FAN_CLASS_NOTIF, 0);
```
```No problem
  int f_notify = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, 0);
```
```Where it manifests
  if( fanotify_mark(f_notify, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
FAN_CREATE , AT_FDCWD, mnt) == -1 ){...}
```

The documentation for fanotify_init() states that no flags are
required in the first argument.  However, doing so using the code
example in the first link to documentation results in an error, with
errno being set to EINVAL.  However, when an additional flag gets
added to fanotify_init() outside the top three flags for control,
there is no error.

For my use case, it seems unnecessary to add additional flags and have
additional work done that I'll never use but that leads me to believe
that this is a kernel bug and I'm not prepared to delve into that
without someone else checking that this is an actual bug and what I
should do to fix it.

