Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D00332845
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 08:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFCGEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 02:04:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33085 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfFCGEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:04:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so150127pfq.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2019 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yu2/QYdYkxpI0wI0753yJjQV9PtoJnQe1VqNNsVS3bs=;
        b=aphubUVhsMiGnUOeMnMyI7lxTq+n3noSCUeF8KThf0z1QHyez9071qGf4/J+0AYx2j
         7EX4qwxxsLfRWNCDGAUOjqeq/8KkSvH1AloNF+LhmFceYYqBZSrKgEQeLr2kL2K/CP1x
         qubXvy77wbW4kepsLxkwBv1aVGLgjMWZj2QyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yu2/QYdYkxpI0wI0753yJjQV9PtoJnQe1VqNNsVS3bs=;
        b=JrKdt1g94XHchH63sZlvhq2I98AzQ+D+zQv/KcyJpM0JdCBn44DdQgol+fZ9WK44G1
         jVFyzzZd7e1VX89FB6VUYJzxdgLIgFFk+fDY+8okPTIthH8gVEw4z1Zrwr4GDj139ogq
         lfRyZBmZljLeJCiNr6bRy57JdI58/AfZsiLhEzCbaLPtiXM0mvacwfbNVa98OD85b+zh
         +ApqViC0K0c9shAXeOTC+on4A5ad0VmPnwXTnDiFeB85j0HU2K4MsZgBUgXISO1BjF1d
         taGlVMBEX8iKHQiJQiG5CFJ3dfykHdluV6+g8qlvW2MQjTwVUt/bFveHWwKai0A/9Qiu
         CqJA==
X-Gm-Message-State: APjAAAWcorSpbSCHODqZ49TbKgkylbVzzAbIKN6TW/x/ieGYLuZyN0bo
        5cu3xlVGKWjh9UXPIKOfF7GSannzQAE=
X-Google-Smtp-Source: APXvYqwT9Vvjbf/NhlVK14zjh2bM51qRa/LyZ6n7vlQ4k8i3JEcJFFi/CRT05Ww3oEry4M4uabCyRQ==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr2690037pjq.87.1559541877706;
        Sun, 02 Jun 2019 23:04:37 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id n7sm4351814pgi.54.2019.06.02.23.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 23:04:36 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna <nayna@linux.vnet.ibm.com>, nayna@linux.ibm.com,
        cclaudio@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        greg@kroah.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
In-Reply-To: <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
References: <20190520062553.14947-1-dja@axtens.net> <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
Date:   Mon, 03 Jun 2019 16:04:32 +1000
Message-ID: <87zhmzxkzz.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nayna,

>> As PowerNV moves towards secure boot, we need a place to put secure
>> variables. One option that has been canvassed is to make our secure
>> variables look like EFI variables. This is an early sketch of another
>> approach where we create a generic firmware variable file system,
>> fwvarfs, and an OPAL Secure Variable backend for it.
>
> Is there a need of new filesystem ? I am wondering why can't these be=20
> exposed via sysfs / securityfs ?
> Probably, something like... /sys/firmware/secureboot or=20
> /sys/kernel/security/secureboot/=C2=A0 ?

I suppose we could put secure variables in sysfs, but I'm not sure
that's what sysfs was intended for. I understand sysfs as "a
filesystem-based view of kernel objects" (from
Documentation/filesystems/configfs/configfs.txt), and I don't think a
secure variable is really a kernel object in the same way most other
things in sysfs are... but I'm open to being convinced.

securityfs seems to be reserved for LSMs, I don't think we can put
things there.

My hope with fwvarfs is to provide a generic place for firmware
variables so that we don't need to expand the list of firmware-specific
filesystems beyond efivarfs. I am also aiming to make things simple to
use so that people familiar with firmware don't also have to become
familiar with filesystem code in order to expose firmware variables to
userspace.

> Also, it sounds like this is needed only for secure firmware variables=20
> and does not include
> other firmware variables which are not security relevant ? Is that=20
> correct understanding ?

The primary use case at the moment - OPAL secure variables - is security
focused because the current OPAL secure variable design stores and
manipulates secure variables separately from the rest of nvram. This
isn't an inherent feature of fwvarfs.

fwvarfs can also be used for variables that are not security relevant as
well. For example, with the EFI backend (patch 3), both secure and
insecure variables can be read.

Regards,
Daniel
