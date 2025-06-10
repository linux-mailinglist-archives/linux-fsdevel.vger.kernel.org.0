Return-Path: <linux-fsdevel+bounces-51211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88BAD4703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3800B189C660
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A728C2CB;
	Tue, 10 Jun 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FTOoNxL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9E2874EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599424; cv=none; b=QJB0mdHfMjrPWF2hG43ZkhR+F6XxilqLSVd6m6pvOWXoc3d2OUde9XZyijGI1oXveMTxf6KQij3KvAlRdJGb/XXLyeBuFow/w7wYvo0nzpoQOYF8SzyuSZzBocYDj2IyxHuHRgJ+vHUDpftH624KqG8gefrVvONYf+rd3owdszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599424; c=relaxed/simple;
	bh=5zpmeUIFplYcd16FCJTHwlcr+3eWOrvix0typRp9sog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNCGL0ZpvXNYA+RFsL+AYzelxnVJRIG5Hgno+xTUc8PrePxQpQihMAeX9P9JHS5cPmoiJ2an7OmduCTjmsjkFPmd+9V8mYRw2tRb4yOu9CE1YcLxwBgN4XO5xEYYAMgKhULlK/NZEBEDSLLInGUjr/fUsOGTGVfNUIRbKs13ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FTOoNxL+; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso5456816276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749599421; x=1750204221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Qgp5oHl/0P+qqYYVFIyIBvDmKn+BX8RyiafClKsvk=;
        b=FTOoNxL+0vvlydxtSO2mI5yc5X1tjb179p+F0GAsrKx4xgmGahTCldcYS00Z3ViLIJ
         g0Y+/KMfpS/uwp//Kk5giFqvVPes7d1RHKOvnGNhAKNQiS3Zpi9aLKZH+WVdKR9v8pKk
         iP5Z/yMT64NpQZtKsEeF5dYsY2c6BfyLExb/jp4KkKkflgeqNk1ulDEGmNpOoruuNh4s
         PtB57wiRRix46OR4HDub/HRfv7VXBDVTzTgHgEUHk37pBFwzZgSUSmbqOJ07T2rAAUcd
         xlogZ+m14/YVu0Kq+f3U9z98WdBd48fUqjtkqASQPHLX2xgeTDAgHqdH3SrkzUdOpVeY
         eY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749599421; x=1750204221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Qgp5oHl/0P+qqYYVFIyIBvDmKn+BX8RyiafClKsvk=;
        b=jbnHIDIW1peml24UhPUTTUxGyFvdJo55h86iY/tB01Ki5W1A4brO1GiL9BKGVLp4ea
         Qoz6twihlMYVqA1ygreQ+R+qu1i/EGT0/OVKZjchGnY3acbUiiu78O4wTE1PRv86RRuT
         Lyt6YneSILalhvUQSorFQqRkxlBqjO0zHd3snp3iZUdWnUMxZCKUNfnn6fKBt64jdOo/
         XBn7IKsIRHhZl64T0L9n9Rmka0ZnB/b7EVYUJSSFjWCQaGTvLzn4WVWx4NLhHANcgYwf
         RO2oTtPpT8h4FS7i6tyxDsyIu0bqF8xgSLHZmT0ODPev+kLFXyz0PN4Sw4hxNAlvW9m4
         6lnw==
X-Gm-Message-State: AOJu0Yy0uDWIwX4fOyZs4oqUMprh/j0qgSPVefdwJ6zCxCgp2Uw44vId
	Eas4tB296ZDxbFVlvoByMo2Vx1c7N8qE6Uhbvz4iKf27LeETrN48fBAG1ly4EOsERRiwB3MfkCq
	dtjz3RyRIbf8pf/40XsYXfswzIeeJgvrb4LPS2HzS1mnnxOAwOQI=
X-Gm-Gg: ASbGncuP/CsTLk0edgwbATeeVcJAbgTTcNMx0vJ6rsfE0JrKme+Cp5cigV+1s3+mhS0
	aBDnwm3R9EUZtJE+P8szH1pqumQdbqoe3MxXbsOjPBNCSrL7zccs1ZizxpFK7p5nCSX8g78afXl
	xtK39Li2yoerMKJf7KpXTtDlqwfIT0etAfS5UWtHq4y9M=
X-Google-Smtp-Source: AGHT+IEvtteku/P1uiXxT4gbHUj7G2QQ+RMoFTyCSCZ3iBdan2K1TBvoDyo+Adyk8sCdrfVIToKGxMKUgGG3OtxF/+0=
X-Received: by 2002:a05:6902:72e:b0:e81:78f7:5521 with SMTP id
 3f1490d57ef6-e81fd92a3f2mr2148616276.6.1749599421291; Tue, 10 Jun 2025
 16:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com> <87plfhsa2r.fsf@gmail.com>
In-Reply-To: <87plfhsa2r.fsf@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 19:50:10 -0400
X-Gm-Features: AX0GCFt95pxw11ngH9ypXcXXgINCY4mIRN7SWpVrAA3u5KTm4VBIfux35kFrlG4
Message-ID: <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	brauner@kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, eggert@cs.ucla.edu, bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:39=E2=80=AFAM Collin Funk <collin.funk1@gmail.com>=
 wrote:
> Paul Moore <paul@paul-moore.com> writes:
> >> <stephen.smalley.work@gmail.com> wrote:
> >> >
> >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> >> > include security.* xattrs") failed to reset err after the call to
> >> > security_inode_listsecurity(), which returns the length of the
> >> > returned xattr name. This results in simple_xattr_list() incorrectly
> >> > returning this length even if a POSIX acl is also set on the inode.
> >> >
> >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561
> >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always in=
clude security.* xattrs")
> >> >
> >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> > ---
> >> >  fs/xattr.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >>
> >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Resending this as it appears that Stephen's original posting had a
> > typo in the VFS mailing list.  The original post can be found in the
> > SELinux archives:
> >
> > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.w=
ork@gmail.com/
>
> Hi, responding to this message since it has the correct lists.
>
> I just booted into a kernel with this patch applied and confirm that it
> fixes the Gnulib tests that were failing.
>
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> Tested-by: Collin Funk <collin.funk1@gmail.com>
>
> Thanks for the fix.

Al, Christian, are either of you going to pick up this fix to send to
Linus?  If not, any objection if I send this up?

--=20
paul-moore.com

