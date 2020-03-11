Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8BC180FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 06:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCKFXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 01:23:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37256 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgCKFXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:23:05 -0400
Received: by mail-io1-f65.google.com with SMTP id k4so634783ior.4;
        Tue, 10 Mar 2020 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhWEqnexHgncpvxDS2l8sBNTUU1im25PrBPC7w+tOLk=;
        b=FQioROWeCZRT5RbT70b6aS3L4z5A8Xh9+TkXcRo1x7CAqq0IA0ua0MEGE5Uykqe0FL
         s7mGcH8etLLtylbbbK6FSbTb6IJjRhs43A8ysMHl6swkDiSbevywH8PsYFGAc5tuTu4F
         hx5OcZDYIvjseSVuRKJfka41SHIGYvXKH88DsabLaszJEEo8W3EyzPcO//PwBEE3M3gH
         e8lIZX3B3ofO7IvWP08ivloJcQzyEW6krILi2rllnwhYD/9lqaIRca+M2m313QFn0KyF
         ArCoRx8xQTINJyLzKbBhKUuuPeE0059amPOESX5qE3B8OeqEICFbnYjaivOd08jIc7RP
         nwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhWEqnexHgncpvxDS2l8sBNTUU1im25PrBPC7w+tOLk=;
        b=n3/N032rmrj9R99Ha7f+uJs9DCRupeRZV3QHXyxcOiig2sXcCCwcecQSIeRn7ova1S
         y6e0jINgm4wQWfDKcGJjYInk4PfYTtg+ET3VxVXxxUB5mA0tFh8mgkDfjIMSJm24Wp67
         SOvCABNrajYhgZIR9bcCOEVbyPRXbjNRRPx/yhNd/OkUeXWGACnkBCpkmAl5w1he8jtJ
         CWb8MFqRKFpMYNhE6ua/Gp1wCX4LbxISCvITgGwo9pTgv0IWvTO7QEwVIUT0DDRbFWIX
         emH4uq5oBzS8bwVux0MmG2podFv4WwoGrqjAjk/B/spSFZDJPUBT1dK0qIidDQb8R63A
         jiYg==
X-Gm-Message-State: ANhLgQ1Qbx6sWtTCHDlVSCfAePTxBHVBreHAsdVT4cbGobcwF84DW0Tb
        IMNCLMoEMJc3FqSYgVRf4gnyqCBRzxhBU0Ma4Nk=
X-Google-Smtp-Source: ADFU+vtANanN8/PEuGjCzSXszWB2s1uvEicvF+tk9dez9cHRd+Aa9rbD4VGIuhF4w32MFOQw+Ll20yj+6BJ6OuZClyY=
X-Received: by 2002:a6b:784a:: with SMTP id h10mr1383631iop.64.1583904182703;
 Tue, 10 Mar 2020 22:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Mar 2020 07:22:51 +0200
Message-ID: <CAOQ4uxi_Xrf+iyP6KVugFgLOfzUvscMr0de0KxQo+jHNBCA9oA@mail.gmail.com>
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 7:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> This patch series adds DAX support to virtiofs filesystem. This allows
> bypassing guest page cache and allows mapping host page cache directly
> in guest address space.
>
> When a page of file is needed, guest sends a request to map that page
> (in host page cache) in qemu address space. Inside guest this is
> a physical memory range controlled by virtiofs device. And guest
> directly maps this physical address range using DAX and hence gets
> access to file data on host.
>
> This can speed up things considerably in many situations. Also this
> can result in substantial memory savings as file data does not have
> to be copied in guest and it is directly accessed from host page
> cache.
>
> Most of the changes are limited to fuse/virtiofs. There are couple
> of changes needed in generic dax infrastructure and couple of changes
> in virtio to be able to access shared memory region.
>
> These patches apply on top of 5.6-rc4 and are also available here.
>
> https://github.com/rhvgoyal/linux/commits/vivek-04-march-2020
>
> Any review or feedback is welcome.
>
[...]
>  drivers/dax/super.c                |    3 +-
>  drivers/virtio/virtio_mmio.c       |   32 +
>  drivers/virtio/virtio_pci_modern.c |  107 +++
>  fs/dax.c                           |   66 +-
>  fs/fuse/dir.c                      |    2 +
>  fs/fuse/file.c                     | 1162 +++++++++++++++++++++++++++-

That's a big addition to already big file.c.
Maybe split dax specific code to dax.c?
Can be a post series cleanup too.

Thanks,
Amir.
