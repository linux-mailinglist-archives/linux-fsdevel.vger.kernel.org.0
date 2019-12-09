Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F174611763D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLITth convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 9 Dec 2019 14:49:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51885 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLITth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:49:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so645660wme.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 11:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=FetqLdZTgqYVH7ikYZFDoVL0KC42SrD46xkQJuqyRM0=;
        b=D4FKWwnk2jTWxnDdYI32gX/l71pPP21Vb+4QSAffYLr1ob7l7eU7qJnX7En7zU8Z6q
         wqZIiAjlogRbbGhwsMbwjx5kL15P8AESTWnT28UmIPSldh3PlBOZSsAbqG1rnhioCXQ+
         qd5R8fqa4/PLCEMoDdZ/Wzrrd4qmzRdJNvlprkdazaruZuHTedriG8srHqmxdBbJGV4k
         buyKm1wDwXKH1BCC/AIpJuvHKOaxD7bunlL33Yw6bHHjC2CLjji4PKrzaNxdhCC5cUc2
         CvXmgyHrzeWPoGhp63zquS2NrLegJrd3QG17hOWsBLKgZ/2Rk32HrC2M7hgvGmClO3HP
         hTYw==
X-Gm-Message-State: APjAAAWWJOZA2EqJd0C0vfzlxB1jFI1eQaf5jv29T6m7m9DFNCKIiQ7Y
        NqQUqu8NH0b3fiPuTxHNjlzHcg==
X-Google-Smtp-Source: APXvYqzwdtZwcs4aWr/n3Y0vKZr/hBTDd8QXrLwOo8iigFvCVNTzOKX0Gg9TpN8KcfynfzDWIDYi9w==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr819910wma.24.1575920974952;
        Mon, 09 Dec 2019 11:49:34 -0800 (PST)
Received: from [10.152.225.171] ([185.81.138.20])
        by smtp.gmail.com with ESMTPSA id y6sm590029wrl.17.2019.12.09.11.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:49:34 -0800 (PST)
Date:   Mon, 09 Dec 2019 20:49:30 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191209192959.GB10721@redhat.com>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal> <20191209192959.GB10721@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in conjunction with user trap
To:     Oleg Nesterov <oleg@redhat.com>, Sargun Dhillon <sargun@sargun.me>
CC:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, luto@amacapital.net, viro@zeniv.linux.org.uk
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On December 9, 2019 8:30:00 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com> wrote:
>On 12/09, Sargun Dhillon wrote:
>>
>> +#define CHILD_PORT_TRY_BIND	80
>> +#define CHILD_PORT_ACTUAL_BIND	4998
>
>...
>
>> +static int handle_req(int listener)
>> +{
>> +	struct sockaddr_in addr = {
>> +		.sin_family	= AF_INET,
>> +		.sin_port	= htons(4998),
>
>then I think
>		.sin_port = htons(CHILD_PORT_ACTUAL_BIND);
>
>would be more clear...
>
>> +		.sin_addr	= {
>> +			.s_addr	= htonl(INADDR_LOOPBACK)
>> +		}
>> +	};
>> +	struct ptrace_getfd_args getfd_args = {
>> +		.options = PTRACE_GETFD_O_CLOEXEC
>> +	};
>> +	struct seccomp_notif_sizes sizes;
>> +	struct seccomp_notif_resp *resp;
>> +	struct seccomp_notif *req;
>> +	int fd, ret = 1;
>> +
>> +	if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
>> +		perror("seccomp(GET_NOTIF_SIZES)");
>> +		goto out;
>> +	}
>> +	req = malloc(sizes.seccomp_notif);
>> +	if (!req)
>> +		goto out;
>> +	memset(req, 0, sizeof(*req));
>> +
>> +	resp = malloc(sizes.seccomp_notif_resp);
>> +	if (!resp)
>> +		goto out_free_req;
>> +	memset(resp, 0, sizeof(*resp));
>> +
>> +	if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
>> +		perror("ioctl recv");
>> +		goto out;
>> +	}
>> +	printf("Child tried to call bind with fd: %lld\n",
>req->data.args[0]);
>> +	getfd_args.fd = req->data.args[0];
>> +	fd = ptrace_getfd(req->pid, &getfd_args);
>
>and iiuc otherwise you do not need to ptrace the child. So you could
>remove
>ptrace(PTRACE_SEIZE) in main() and just do
>
>	ptrace(PTRACE_SEIZE, req->pid);
>	fd = ptrace_getfd(req->pid, &getfd_args);
>	ptrace(PTRACE_DETACH, req->pid);
>
>here. However, PTRACE_DETACH won't work, it needs the stopped tracee.
>We can
>add PTRACE_DETACH_ASYNC, but this makes me think that PTRACE_GETFD has
>nothing
>to do with ptrace.
>
>May be a new syscall which does ptrace_may_access() + get_task_file()
>will make
>more sense?
>
>Oleg.

Once more since this annoying app uses html by default...

But we can already do this right now and this is just an improvement.
That's a bit rich for a new syscall imho...

Christian
