Return-Path: <linux-fsdevel+bounces-42566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DDA43BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E71886BB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA15264F9D;
	Tue, 25 Feb 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dF3BFq0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BF33981;
	Tue, 25 Feb 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479871; cv=none; b=q6p8j1h5MOLgxqG0OsQfKTHHC4FYEpmTRqy/4giVrLg7aVZ5vVRhKdlAxvM5GZwSbIUeeC6NwmItln+Hmv4/H4/KShhslPspM6F4N6IyDRDortm5PRu7WI/Ru7RQcItEC8HCHWllfKBozCpe1lohHBgXWTZNFn2XdrXLXtPyvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479871; c=relaxed/simple;
	bh=RmuohZsGKRJn8ZSVEgb9yStQAk8o1NUhogGprx7O9PU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JmUGQk2zGlYqrau/yal17L0tzwjmi3cODFkMX1tLyeQp9lJYfIIUR9AmpX1/mGjZBKjVuwLfWhBtyM22cDJaA93jqDC0qiFGaMQUSHxaT1groL+yE8Rr1rXmgSafLKGf/5jVSgvAUBc8Mm1KVhQyRN3XBjpvn5SbKubjltSZS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dF3BFq0A; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uz53DfJ8sPKLjR4oalBeJFPjDH5pBX1GJqpCzJiXeWg=; b=dF3BFq0A+/03kmDENk7U8ijpwD
	KbcFXr3fdXLIiPzr+6C89/vTcWNKaSIzX4WHRJaaEBCM+OCen4auri/JWYWji1oak+ZUiLMl/K+tN
	JP1/aqALIxeOw1TAsIHko9lii2ishxFrJJARZQjRBExEpGfg2X1jo6FWH+UeIbxT/tY6ddsBk7FFj
	jsKaA0FmvKBZyjNJMiGuj/JU43otMhvSWN/sxupiF+ZMWW8Ac+5+RVTIOWt51ppz02p2cxK+QNCFO
	FpAJbYyA1mhFkdw1XUYf3vDxAAZEzHC0Mti8WIIEMxCtS/UtiGoFx4SS54+RRlNwwjZr+LLPlFl4F
	XyBOUYSA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmsJm-000L4t-1o; Tue, 25 Feb 2025 11:37:43 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Bernd
 Schubert <bernd@bsbernd.com>,  Teng Qin <tqin@jumptrading.com>,  Matt
 Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
In-Reply-To: <CAJfpeguQTZ8KcdffKvY8kknZVnBH6h3Tz1GSESwBjXSz_25TLw@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 24 Feb 2025 15:39:38 +0100")
References: <20250130101607.21756-1-luis@igalia.com>
	<CAJfpegsrGO25sJe1GQBVe=Ea5jhkpr7WjpQOHKxkL=gJTk+y8g@mail.gmail.com>
	<87tt8j4dqe.fsf@igalia.com>
	<CAJfpeguQTZ8KcdffKvY8kknZVnBH6h3Tz1GSESwBjXSz_25TLw@mail.gmail.com>
Date: Tue, 25 Feb 2025 10:37:28 +0000
Message-ID: <87v7sy48ev.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24 2025, Miklos Szeredi wrote:

> On Mon, 24 Feb 2025 at 15:30, Luis Henriques <luis@igalia.com> wrote:
>>
>> On Mon, Feb 24 2025, Miklos Szeredi wrote:
>>
>> > On Thu, 30 Jan 2025 at 11:16, Luis Henriques <luis@igalia.com> wrote:
>> >>
>> >> Userspace filesystems can push data for a specific inode without it b=
eing
>> >> explicitly requested.  This can be accomplished by using NOTIFY_STORE.
>> >> However, this may race against another process performing different
>> >> operations on the same inode.
>> >>
>> >> If, for example, there is a process reading from it, it may happen th=
at it
>> >> will block waiting for data to be available (locking the folio), whil=
e the
>> >> FUSE server will also block trying to lock the same folio to update i=
t with
>> >> the inode data.
>> >>
>> >> The easiest solution, as suggested by Miklos, is to allow the userspa=
ce
>> >> filesystem to skip locked folios.
>> >
>> > Not sure.
>> >
>> > The easiest solution is to make the server perform the two operations
>> > independently.  I.e. never trigger a notification from a request.
>> >
>> > This is true of other notifications, e.g. doing FUSE_NOTIFY_DELETE
>> > during e.g. FUSE_RMDIR will deadlock on i_mutex.
>>
>> Hmmm... OK, the NOTIFY_DELETE and NOTIFY_INVAL_ENTRY deadlocks are
>> documented (in libfuse, at least).  So, maybe this one could be added to
>> the list of notifications that could deadlock.  However, IMHO, it would =
be
>> great if this could be fixed instead.
>>
>> > Or am I misunderstanding the problem?
>>
>> I believe the initial report[1] actually adds a specific use-case where
>> the deadlock can happen when the server performs the two operations
>> independently.  For example:
>>
>>   - An application reads 4K of data at offset 0
>>   - The server gets a read request.  It performs the read, and gets more
>>     data than the data requested (say 4M)
>>   - It caches this data in userspace and replies to VFS with 4K of data
>>   - The server does a notify_store with the reminder data
>>   - In the meantime the userspace application reads more 4K at offset 4K
>>
>> The last 2 operations can race and the server may deadlock if the
>> application already has locked the page where data will be read into.
>
> I don't see the deadlock.  If the race was won by the read, then it
> will proceed with FUSE_READ and fetch the data from the server.  When
> this is finished,  NOTIFY_STORE will overwrite the page with the same
> data.

OK, that makes sense.  Took a bit to go through all this again, but I
agree that the only thing to do in then is probably to add a warning to
the libfuse API documentation, in fuse_lowlevel_notify_store(), as shown
below.  (I'll prepare an MR for that.)

Thank you, Miklos.

Cheers,
--=20
Lu=C3=ADs

diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 93bcba296c2d..d1f9717347da 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1845,6 +1845,10 @@ int fuse_lowlevel_notify_delete(struct fuse_session =
*se,
  * If the stored data overflows the current file size, then the size
  * is extended, similarly to a write(2) on the filesystem.
  *
+ * To avoid a deadlock this function must not be called while executing
+ * a related filesystem operation (e.g. while replying to a FUSE_READ
+ * request).
+ *
  * If this function returns an error, then the store wasn't fully
  * completed, but it may have been partially completed.
  *

