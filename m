Return-Path: <linux-fsdevel+bounces-24418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B793F328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9ED1F21145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E11448FA;
	Mon, 29 Jul 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbOYQZVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F613A258;
	Mon, 29 Jul 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250260; cv=none; b=RXuKEcZAWsFgH25RshyLvfzZwqJlencQXpFNMlIimQ6QKbVyk/30zzY8M7Et53cVfWFqBTnZHo9eaEomAXFHKwqdWHT8diF+0jphdM4xaRN3tTHqXdAbvwXtWOBNrxG045Jw32eEPXF0XCurLZPT6l16an39a8Gl3hSqB+dRejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250260; c=relaxed/simple;
	bh=E1WNOV1A24hRQB3PV9kfV1aAXYy/c25OZZYctZbaaKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpmTTOKzQcARfccsssPew79ztaWlSJYE1+eoltCIbNtj6zMCl0hNyTMU11yYdYGkgAeCtnKhuQtqOtYw3jEUGbVad1cs0+6fmwT5VgqMhmFFM1bUgkdWa6gI2UYvHwLhR1+4cuoxeSwwOyBYS2hqT0346tCdhZ/lhoEOr+OE12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbOYQZVK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3685b9c8998so1146810f8f.0;
        Mon, 29 Jul 2024 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722250257; x=1722855057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IW5wOKHblGmDToKRtpXTAMfWK+BkA1IqVz0LHIW/pGw=;
        b=AbOYQZVK+STyP0sOi26U5uaUSrFT3exe3q6uM22mmUA2QsYGq0j7VHkc39277OBU57
         Wotmkc+aF0TPOKuNXH8L0Ne44yZtRV3ggvmCbRG2VdkXvUQOnR3h/7LXg4ngfaiadRSo
         wpYLlJU6Y+xIV5zS8ho14EnPpKCmyIQ2g5OdvgbOBDZ3nMQq8yYKnf6rJzlA/I8/bRZ2
         fTkRRmbIYrASfnNs2YAOyGDTreSiyaG9+IKaCteNngq4vrB82AiPCCVMFG8Js5oJlsSB
         K5j3KKaUkxHG1AeGEF1UuUZa6OHiWNt01navyAf8ZHuwxyxIh54waDmkxFrhDSlHWgOH
         jm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250257; x=1722855057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW5wOKHblGmDToKRtpXTAMfWK+BkA1IqVz0LHIW/pGw=;
        b=ND5JlSZiMnrL0Chxts3e0M3QEr0haCPcRj9HRnPZYCB3l9fHwzT2sg8enNFFm8OJV8
         2JK9H0hJ8RB2SEZ8ZdFh112ChKte59eYmbhrKfGnrOTtsPbuXM9BkZWR5GsbuAxEIG53
         b4BdcKXEKQENgaKtf2xy6BudFBgZ1QrzOStw+o6SvaMiM5agGAxwfDN6qIuvJS57QSs7
         kzIxNmzGvMNaAAcKBzW36JVP8PpqO+zd293q2LC6CES7BNA7NWBrqI9bvyEIutUkXEDs
         1A8nJ1JIY+8b89MTZ/7e6MfD18AR7lu4lLulM5XqetVKKpYsXRokTIIobqqkHyrY7dsf
         LxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO9QS9mFOJcevGuLLEjpzlE5hj4zTxdUdibwpTyUPaC5+92uN/TvgYlJN8TIBmCxRriiTW1DaL3IRoZ23MI3Vwm05GES5wQrsSLE6IasLwmXWW/bmfeIeg34YHW3Z+ELajiRkfjabp
X-Gm-Message-State: AOJu0Yy6nBFxCO5mub7odKLfJroHIPGiVPAOpB6imqc+ZxyxcsnJiVOz
	BbCcUty232lMRiT38juDjy1USfyF9yt8oEafJ+gfaeQoVAhTA7pB
X-Google-Smtp-Source: AGHT+IFEKvYL6l+kHjAH91T5CPYfIGssFHEHwro3WTELISWS0FkcH0HSsjaWH+DSOIIWR29oWt01gw==
X-Received: by 2002:a05:6000:104a:b0:367:923b:656b with SMTP id ffacd0b85a97d-36b5d0b79d9mr4817366f8f.54.1722250256581;
        Mon, 29 Jul 2024 03:50:56 -0700 (PDT)
Received: from f (cst-prg-68-42.cust.vodafone.cz. [46.135.68.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367f0e26sm11906515f8f.47.2024.07.29.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:50:56 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:50:47 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xsoqy58.fsf@oldenburg.str.redhat.com>

On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> * Mateusz Guzik:
> 
> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> >> It was pointed out to me that inode numbers on Linux are no longer
> >> expected to be unique per file system, even for local file systems.
> >
> > I don't know if I'm parsing this correctly.
> >
> > Are you claiming on-disk inode numbers are not guaranteed unique per
> > filesystem? It sounds like utter breakage, with capital 'f'.
> 
> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> local file systems are different.
> 

Can you link me some threads about this?

> > While the above is not what's needed here, I guess it sets a precedent
> > for F_DUPINODE_QUERY (or whatever other name) to be added to handily
> > compare inode pointers. It may be worthwhile regardless of the above.
> > (or maybe kcmp could be extended?)
> 
> I looked at kcmp as well, but I think it's dependent on
> checkpoint/restore.  File sameness checks are much more basic than that.
> 

I had this in mind (untested modulo compilation):

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..5723c3e82eac 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -343,6 +343,13 @@ static long f_dupfd_query(int fd, struct file *filp)
 	return f.file == filp;
 }
 
+static long f_dupfd_query_inode(int fd, struct file *filp)
+{
+	CLASS(fd_raw, f)(fd);
+
+	return f.file->f_inode == filp->f_inode;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -361,6 +368,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_DUPFD_QUERY:
 		err = f_dupfd_query(argi, filp);
 		break;
+	case F_DUPFD_QUERY_INODE:
+		err = f_dupfd_query_inode(argi, filp);
+		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
 		break;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..2e93dbdd8fd2 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -16,6 +16,8 @@
 
 #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
 
+#define F_DUPFD_QUERY_INODE (F_LINUX_SPECIFIC_BASE + 4)
+
 /*
  * Cancel a blocking posix lock; internal use only until we expose an
  * asynchronous lock api to userspace:

