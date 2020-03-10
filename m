Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A118080A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCJT34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 15:29:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43891 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgCJT34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:29:56 -0400
Received: by mail-io1-f65.google.com with SMTP id n21so13981509ioo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+5kKx2vjd+32qtXdrToSkdcaTFfCoL0XwTHvIf1Udg=;
        b=aK5PVE29ZcX0JiUctdQKR6J4V8Ui1eAIPqRanRd0A6P1wY0Olma3AwHhrD2PySTEY1
         kZXXW4WCwVRDmSdrzbH44gRLv2dG0A/Uo2FsE583gbPAcJns18ZxYKCVeIw3hoRvR9nW
         X63aa+sKmNAHbQ4QA3pDh67PTQqXiIq2fbgVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+5kKx2vjd+32qtXdrToSkdcaTFfCoL0XwTHvIf1Udg=;
        b=cKFb1drUc+8W0y3B1vO4eoID57z8a3PQgQzbk2C9siZN4fe9RQ7QHUWf+28jGB0vfD
         IXPPHUsIUoYweqdoOUOLuRr8yxxE3eFjxWGi/LF6g3PkivA1dPIPTHjbc4mvCtwhlbDd
         ebXyt7F9A6cUmBY6LxusRAOPNVzZPQay4DUHFI0Mc4q7JPJ6RWkvxyRB59ybFoUFVQ+l
         dAB3lUY0EKHPnXtbd8PLAmbnWZDBBgN3uIZst396CDrvGaODlInekLQ4hivwjY4HEuVd
         ZgG5Q5UuyOgmjaMEbmgaqQzlOm+oFNiKR+1mK5emgJ4ZG8skVulg+hno813X9BceO5Li
         nflA==
X-Gm-Message-State: ANhLgQ0Z9VP4WNBczoaiUE+KPU0CWEbT6oZv6dib8sKv0nlKuDuNVB3R
        dQGpZ8VXo4iwmAEiuK9RK5T0RBDa59oY5bMrcYtcCgX4YII=
X-Google-Smtp-Source: ADFU+vtsHIE3juf6VloEHRQ+IFMzK3xP4NZGmqU4UP+Nis9eHwUR1TaPlSRS7pe1JGlIhD+fR0kBGJFzXYHNxz1Bts4=
X-Received: by 2002:a02:7a07:: with SMTP id a7mr12556058jac.77.1583868594718;
 Tue, 10 Mar 2020 12:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-11-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-11-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:29:43 +0100
Message-ID: <CAJfpegshzZB=e3npbY3h9VOLMwAgLtQ3PJSC8AupF_d3FW9few@mail.gmail.com>
Subject: Re: [PATCH 10/20] fuse,virtiofs: Keep a list of free dax memory ranges
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Divide the dax memory range into fixed size ranges (2MB for now) and put
> them in a list. This will track free ranges. Once an inode requires a
> free range, we will take one from here and put it in interval-tree
> of ranges assigned to inode.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
