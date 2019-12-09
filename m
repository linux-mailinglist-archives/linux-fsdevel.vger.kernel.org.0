Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47F01177B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 21:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLIUqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 15:46:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbfLIUqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575924407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvGxejde19Gce3IT94gbjW52qT1tnhP9TIAUg/7+ybA=;
        b=P8GupNdf2tOVwc+jG/MFTaBF2AUWHhDjHpHQ6cjD9oicuBx1nOjMspzPnJat4zfDU0sAVi
        ouXvt0TMgAGfScRWsUuu+SfJKI5lXSvLzHC6q5m0ybzsl6+Z2RJ1sF3T3mD84KIcFooyY9
        wzNx+Qjj6NUi/qfKr8dfn7pKzAXFNjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-TMQKf60QPd6sKPR1BUnflg-1; Mon, 09 Dec 2019 15:46:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B6431856A60;
        Mon,  9 Dec 2019 20:46:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0219B60BE1;
        Mon,  9 Dec 2019 20:46:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  9 Dec 2019 21:46:39 +0100 (CET)
Date:   Mon, 9 Dec 2019 21:46:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, luto@amacapital.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191209204635.GC10721@redhat.com>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
 <20191209192959.GB10721@redhat.com>
 <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
MIME-Version: 1.0
In-Reply-To: <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TMQKf60QPd6sKPR1BUnflg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/09, Christian Brauner wrote:
>
> >We can
> >add PTRACE_DETACH_ASYNC, but this makes me think that PTRACE_GETFD has
> >nothing
> >to do with ptrace.
> >
> >May be a new syscall which does ptrace_may_access() + get_task_file()
> >will make
> >more sense?
> >
> >Oleg.
>=20
> Once more since this annoying app uses html by default...
>=20
> But we can already do this right now and this is just an improvement.
> That's a bit rich for a new syscall imho...

I agree, and I won't really argue...

but the changelog in 2/4 says

=09The requirement that the tracer has attached to the tracee prior to the
=09capture of the file descriptor may be lifted at a later point.

so may be we should do this right now?

plus this part

=09@@ -1265,7 +1295,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, =
unsigned long, addr,
=09=09}
=09=20
=09=09ret =3D ptrace_check_attach(child, request =3D=3D PTRACE_KILL ||
=09-=09=09=09=09  request =3D=3D PTRACE_INTERRUPT);
=09+=09=09=09=09  request =3D=3D PTRACE_INTERRUPT ||
=09+=09=09=09=09  request =3D=3D PTRACE_GETFD);

actually means "we do not need ptrace, but we do not know where else we
can add this fd_install(get_task_file()).

Oleg.

