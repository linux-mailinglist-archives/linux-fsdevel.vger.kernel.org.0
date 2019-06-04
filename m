Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A173235095
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFDUF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 16:05:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37997 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFDUF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:05:57 -0400
Received: by mail-it1-f194.google.com with SMTP id h9so28603itk.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2019 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZREhuJlsDtH89ZVDYphzf41RLCVZZkM936cBZurEuKE=;
        b=pv/6OPT1BwcW5kLEBR+t89bzJ6UremuUyrRRzifMONzXagldwUIj4ryQti4Jce45X3
         YEqlt80vgw/1s9GumZrTUbCOUG1NmsmW6pUOoHe9r1iHLbpAPBsMiCQti4XuzcoymGTf
         yRK4Yp32kJT1dNc4oAtYkpiMcmE6Y3X7yQXCgUTLsgrsSA7TI8MEz14fbjA3EbNcjAlY
         2idbOTzsQd664g8fX2JJ8XhDoeqMwDy4YUdEwBa5PaQXDZn8oJjRkRjkseIlZr4mFJto
         QT6ZqnKS7YsQaium2oEVGTjkIDxej2XHbJmZ/VKarQFFIw/oW3HevHdtuWUbxY+c7WM1
         NCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZREhuJlsDtH89ZVDYphzf41RLCVZZkM936cBZurEuKE=;
        b=XVuJ/QSysZi0Ak7y9T1ZRYU055HylW48JXhGRuQnY0co+J/JWsOaBOUOrT7sLV0zW+
         Am17QiExA32ObNJ6msDCm77aJII/RxriNaDVucacogMotorsGVaW1XOFILUYQ9SI3k3N
         fBEOg3PCB4ylj2B0TlvG/TEtFCGYW0KMfEIAJFSQheHEe+FsegyGjkwEvNManO0S4wXT
         idiKbpexRDw1ZSsPpXY9Hv6VmnDXMtbq2KjcuwlpwDQ0qwhGsNLPKrFpb6OqA14Fg1IN
         QSIg0ltxI0EpIG2K2OYilcxSAHaHzIv4qyCLk5aJfLURT/U9wsC292Endg9qREtrTQDu
         ta+g==
X-Gm-Message-State: APjAAAU7os6tGU61puRd3R4VPLJr4EkQOXYtcFabdsuv5wSanznj8YgH
        JM5xFmJdBuIiFebCvQvsTfYfNNYXldX5+o6CyUjhMA==
X-Google-Smtp-Source: APXvYqwsa9hUdLg9OFkrqEiChjF1ClMm07RxLnCex43+ESQGujO4p+QXESe0Hiljy+pNbzZoo6W0gnVr8MJ1YwSahpo=
X-Received: by 2002:a24:bd4:: with SMTP id 203mr22280225itd.119.1559678756641;
 Tue, 04 Jun 2019 13:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190520062553.14947-1-dja@axtens.net> <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
 <87zhmzxkzz.fsf@dja-thinkpad.axtens.net> <20190603072916.GA7545@kroah.com>
 <87tvd6xlx9.fsf@dja-thinkpad.axtens.net> <b2312934-42a6-f2e7-61d2-3d95222a1699@linux.vnet.ibm.com>
In-Reply-To: <b2312934-42a6-f2e7-61d2-3d95222a1699@linux.vnet.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 4 Jun 2019 13:05:45 -0700
Message-ID: <CACdnJutpgxd0Se-UDR4Gw3s+KfTuHprUTqFqxq+qu17vd4xr7Q@mail.gmail.com>
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 4, 2019 at 1:01 PM Nayna <nayna@linux.vnet.ibm.com> wrote:
> It seems efivars were first implemented in sysfs and then later
> separated out as efivarfs.
> Refer - Documentation/filesystems/efivarfs.txt.
>
> So, the reason wasn't that sysfs should not be used for exposing
> firmware variables,
> but for the size limitations which seems to come from UEFI Specification.
>
> Is this limitation valid for the new requirement of secure variables ?

I don't think the size restriction is an issue now, but there's a lot
of complex semantics around variable deletion and immutability that
need to be represented somehow.
