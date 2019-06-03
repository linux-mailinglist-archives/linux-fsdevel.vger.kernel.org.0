Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84C933C29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 01:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFCX44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 19:56:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40350 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCX44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:56:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id g69so7583329plb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2019 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Dr+tKOWu/al28vwIIjNYvAuukyFW8hKUum7otTy/uaA=;
        b=dubeixfj68GROHvhQHl0TlgQvu/qN/dWxG1uhGXl+b7q62F7H3YF35N5zDt03TmrJ7
         yUx4Ofi2kFL0A1GmstkucQ9mLj9GR5BERQQKy6WpIkw8/QhrNJSwZA8b7QJCaLszz6ih
         RI9+kPPLq9Lg3k/JFSXuwHLwkPDt+Tj+Gx3AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Dr+tKOWu/al28vwIIjNYvAuukyFW8hKUum7otTy/uaA=;
        b=Id361eGvpHrl4N6no1HojMVTB+kd8tlCc6anc6itVdzqxE31V/0o0yC0NQepqDPVTB
         KIxji6ITek/E3xDk1XIMUHtrbKOgfe2qna7z2rQqAnm7KZajXhiH66U/AgB4oKN9b7UL
         5BJ6vCztf0Vg/3os5QsAEWImKb2tPrsgnz9BGAd0V1gd/qPQD2uhidbPdxK7t/7j+lCU
         qBnpak2drQshceOUQkArtrYVKVpqEGD7+mx8vw4GfrYt2HGgwbPKNzXpcrOjR2BnTR0d
         3nTvG9119PxZ7mIsG7SsrqxSG4IDF0IlWYxfV8ECRk2QB3KPGaxk/IsjDHbZfYbdvxSL
         +b3Q==
X-Gm-Message-State: APjAAAV1sAGdbu0b1IXfp4+Avztea91WKJ5nnca177tClYExnbUPUi32
        taN+ZRmcK3AyaaNawKeqbxVOcg==
X-Google-Smtp-Source: APXvYqz7stKclz4T2A+GKVDzn75Zo74JVpXxm5yfpx5MKL0qgwtv0UZe/qiFCyFpRqvanhLlECh20w==
X-Received: by 2002:a17:902:5c2:: with SMTP id f60mr33105207plf.61.1559606215834;
        Mon, 03 Jun 2019 16:56:55 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id g8sm14414225pjp.17.2019.06.03.16.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 16:56:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, nayna@linux.ibm.com,
        cclaudio@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
In-Reply-To: <20190603072916.GA7545@kroah.com>
References: <20190520062553.14947-1-dja@axtens.net> <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com> <87zhmzxkzz.fsf@dja-thinkpad.axtens.net> <20190603072916.GA7545@kroah.com>
Date:   Tue, 04 Jun 2019 09:56:50 +1000
Message-ID: <87tvd6xlx9.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

>> >> As PowerNV moves towards secure boot, we need a place to put secure
>> >> variables. One option that has been canvassed is to make our secure
>> >> variables look like EFI variables. This is an early sketch of another
>> >> approach where we create a generic firmware variable file system,
>> >> fwvarfs, and an OPAL Secure Variable backend for it.
>> >
>> > Is there a need of new filesystem ? I am wondering why can't these be=
=20
>> > exposed via sysfs / securityfs ?
>> > Probably, something like... /sys/firmware/secureboot or=20
>> > /sys/kernel/security/secureboot/=C2=A0 ?
>>=20
>> I suppose we could put secure variables in sysfs, but I'm not sure
>> that's what sysfs was intended for. I understand sysfs as "a
>> filesystem-based view of kernel objects" (from
>> Documentation/filesystems/configfs/configfs.txt), and I don't think a
>> secure variable is really a kernel object in the same way most other
>> things in sysfs are... but I'm open to being convinced.
>
> What makes them more "secure" than anything else that is in sysfs today?
> I didn't see anything in this patchset that provided "additional
> security", did I miss it?

You're right, there's no additional security. What I should have said
was that I didn't think that _firmware_ variables were kernel objects in
the same way that other things in sysfs are. Having read the rest of
your reply it seems I'm mistaken on this.

> I would just recommend putting this in sysfs.  Make a new subsystem
> (i.e. class) and away you go.
>
>> My hope with fwvarfs is to provide a generic place for firmware
>> variables so that we don't need to expand the list of firmware-specific
>> filesystems beyond efivarfs. I am also aiming to make things simple to
>> use so that people familiar with firmware don't also have to become
>> familiar with filesystem code in order to expose firmware variables to
>> userspace.

>> fwvarfs can also be used for variables that are not security relevant as
>> well. For example, with the EFI backend (patch 3), both secure and
>> insecure variables can be read.
>
> I don't remember why efi variables were not put in sysfs, I think there
> was some reasoning behind it originally.  Perhaps look in the linux-efi
> archives.

I'll have a look: I suspect the appeal of efivarfs is that it allows for
things like non-case-sensitive matching on the GUID part of the filename
while retaining case-sensitivity on the part of the filename
representing the variable name.

As suggested, I'll try a sysfs class. I think that will allow me to
kill off most of the abstraction layer too. Thanks for the input.

Regards,
Daniel

>
> thanks,
>
> greg k-h
