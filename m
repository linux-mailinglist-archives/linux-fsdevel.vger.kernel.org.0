Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2621175DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLITaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 14:30:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726342AbfLITaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575919809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96bBHCk/wtYdQI2alAZrDQ5RvQLwzHoRyT++y2oaMKQ=;
        b=b4xk6D9Fkl4y4j6Zkkev3hlQ+JmPUCH560ASNjGUVhVpEoQfGOp2jFwnc2hZ6SRTTGe1/u
        Y7oXhZvjlV05QUC35Nx0qCcKm51smjt++NVSN4RC7e41Zn2ZzfvD6uvn+hlpqDuL2IImBU
        M7wX1/fB7J4roMh7Vr6J1PzdTi4OvKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-BdXiTdULNw-Roz2xXSZ0WQ-1; Mon, 09 Dec 2019 14:30:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32825107ACC9;
        Mon,  9 Dec 2019 19:30:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E1FE60C05;
        Mon,  9 Dec 2019 19:30:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  9 Dec 2019 20:30:03 +0100 (CET)
Date:   Mon, 9 Dec 2019 20:30:00 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, christian.brauner@ubuntu.com,
        luto@amacapital.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191209192959.GB10721@redhat.com>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
In-Reply-To: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BdXiTdULNw-Roz2xXSZ0WQ-1
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
> +#define CHILD_PORT_TRY_BIND=0980
> +#define CHILD_PORT_ACTUAL_BIND=094998

...

> +static int handle_req(int listener)
> +{
> +=09struct sockaddr_in addr =3D {
> +=09=09.sin_family=09=3D AF_INET,
> +=09=09.sin_port=09=3D htons(4998),

then I think
=09=09.sin_port =3D htons(CHILD_PORT_ACTUAL_BIND);

would be more clear...

> +=09=09.sin_addr=09=3D {
> +=09=09=09.s_addr=09=3D htonl(INADDR_LOOPBACK)
> +=09=09}
> +=09};
> +=09struct ptrace_getfd_args getfd_args =3D {
> +=09=09.options =3D PTRACE_GETFD_O_CLOEXEC
> +=09};
> +=09struct seccomp_notif_sizes sizes;
> +=09struct seccomp_notif_resp *resp;
> +=09struct seccomp_notif *req;
> +=09int fd, ret =3D 1;
> +
> +=09if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
> +=09=09perror("seccomp(GET_NOTIF_SIZES)");
> +=09=09goto out;
> +=09}
> +=09req =3D malloc(sizes.seccomp_notif);
> +=09if (!req)
> +=09=09goto out;
> +=09memset(req, 0, sizeof(*req));
> +
> +=09resp =3D malloc(sizes.seccomp_notif_resp);
> +=09if (!resp)
> +=09=09goto out_free_req;
> +=09memset(resp, 0, sizeof(*resp));
> +
> +=09if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
> +=09=09perror("ioctl recv");
> +=09=09goto out;
> +=09}
> +=09printf("Child tried to call bind with fd: %lld\n", req->data.args[0])=
;
> +=09getfd_args.fd =3D req->data.args[0];
> +=09fd =3D ptrace_getfd(req->pid, &getfd_args);

and iiuc otherwise you do not need to ptrace the child. So you could remove
ptrace(PTRACE_SEIZE) in main() and just do

=09ptrace(PTRACE_SEIZE, req->pid);
=09fd =3D ptrace_getfd(req->pid, &getfd_args);
=09ptrace(PTRACE_DETACH, req->pid);

here. However, PTRACE_DETACH won't work, it needs the stopped tracee. We ca=
n
add PTRACE_DETACH_ASYNC, but this makes me think that PTRACE_GETFD has noth=
ing
to do with ptrace.

May be a new syscall which does ptrace_may_access() + get_task_file() will =
make
more sense?

Oleg.

