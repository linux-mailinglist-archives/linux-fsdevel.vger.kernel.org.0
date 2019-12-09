Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43031170DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIPw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 10:52:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbfLIPw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575906775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWsZtrZZRUqMfa4RKABURKvActJftASGEyBf7iOz0lA=;
        b=ZFrK6PmyXaxJi/Nw//r1NfmssL5w5X2AgMCZp+vKSHK2qIJseVX55Vf4ItdXYqphRzUPAC
        WpKaacCCVOTjvg5p8dsIHLttNP8STMicaLfbg8OffHNuAGZo1iwQc+kU2/FNmOtsZ1P7NL
        hzQNfoSlyRcfCYXg/tYuxPPhNu8Y3v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-FG0lZR-ONcK4G9mKrZ2U7Q-1; Mon, 09 Dec 2019 10:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B67121852E30;
        Mon,  9 Dec 2019 15:52:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id A375D5D6B7;
        Mon,  9 Dec 2019 15:52:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  9 Dec 2019 16:52:49 +0100 (CET)
Date:   Mon, 9 Dec 2019 16:52:45 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, christian.brauner@ubuntu.com,
        luto@amacapital.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 1/4] vfs, fdtable: Add get_task_file helper
Message-ID: <20191209155242.GC5388@redhat.com>
References: <20191209070609.GA32438@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
In-Reply-To: <20191209070609.GA32438@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FG0lZR-ONcK4G9mKrZ2U7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/09, Sargun Dhillon wrote:
>
> +struct file *get_task_file(struct task_struct *task, unsigned int fd)
> +{
> +=09struct file *file =3D NULL;
> +
> +=09task_lock(task);
> +=09rcu_read_lock();
> +
> +=09if (task->files) {
> +=09=09file =3D fcheck_files(task->files, fd);
> +=09=09if (file && !get_file_rcu(file))
> +=09=09=09file =3D NULL;
> +=09}

On second thought this is not exactly right, get_file_rcu() can fail if
get_task_file() races with dup2(), in this case we need to do fcheck_files(=
)
again. And this is what __fget() already does, so may be the patch below
makes more sense?

I will leave this to other reviewers, but suddenly I recall that I have
already sent the patch which adds a similar helper a while ago.

See https://lore.kernel.org/lkml/20180915160423.GA31461@redhat.com/

In short, get_files_struct() should be avoided because it can race with
exec() and break POSIX locks which use ->fl_owner =3D files_struct.

Oleg.

--- x/fs/file.c
+++ x/fs/file.c
@@ -706,9 +706,9 @@ void do_close_on_exec(struct files_struc
 =09spin_unlock(&files->file_lock);
 }
=20
-static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int ref=
s)
+static struct file *__fget_files(struct files_struct *files, unsigned int =
fd,
+=09=09=09=09=09fmode_t mask, unsigned int refs)
 {
-=09struct files_struct *files =3D current->files;
 =09struct file *file;
=20
 =09rcu_read_lock();
@@ -729,6 +729,23 @@ loop:
 =09return file;
 }
=20
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+=09struct file *file;
+
+=09task_lock(task);
+=09if (task->files)
+=09=09file =3D __fget_files(task->files, fd, 0, 1);
+=09task_unlock(task);
+
+=09return file;
+}
+
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int ref=
s)
+{
+=09return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 =09return __fget(fd, FMODE_PATH, refs);

