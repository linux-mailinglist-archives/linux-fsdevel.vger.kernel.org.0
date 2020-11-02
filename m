Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB62A2CE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 15:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKBO0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 09:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgKBO0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604327173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2zRKLgNsnXTGjSSS56WpLlhmJPfrlhiyUVGzUpqBHE=;
        b=ZGeBdoiH8qLRlDJk9eLe+dYtXSAVu8TF3ix7RBiT4SG0b79Y3EQ48xw39BKEnbJQsK+k7S
        UF/5FIEU8s5DNJHdElzpTD7Kfg65SNUbAO1b1ZBNfxrsILDq0Djp1WM85EHg1up/QyEuXk
        TkuAGKjrIr5qbF10VuAORc4wFH9wV34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-L8aQTOltN0aPgeK5VZD5WQ-1; Mon, 02 Nov 2020 09:26:10 -0500
X-MC-Unique: L8aQTOltN0aPgeK5VZD5WQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A83FA18BA283;
        Mon,  2 Nov 2020 14:26:08 +0000 (UTC)
Received: from ovpn-112-12.rdu2.redhat.com (ovpn-112-12.rdu2.redhat.com [10.10.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5EB05DA6B;
        Mon,  2 Nov 2020 14:25:57 +0000 (UTC)
Message-ID: <77529e99ca9c2d228a67dd8d789d83afdcd1ace3.camel@redhat.com>
Subject: Re: WARN_ON(fuse_insert_writeback(root, wpa)) in tree_insert()
From:   Qian Cai <cai@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Date:   Mon, 02 Nov 2020 09:25:57 -0500
In-Reply-To: <CAJfpegv4jLewQ4G_GdxraTE8fGHy7-d52gPSi4ZAOp0N4aYJnw@mail.gmail.com>
References: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com>
         <89f0dbf6713ebd44ec519425e3a947e71f7aed55.camel@redhat.com>
         <CAJfpegv4jLewQ4G_GdxraTE8fGHy7-d52gPSi4ZAOp0N4aYJnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-29 at 16:20 +0100, Miklos Szeredi wrote:
> On Thu, Oct 29, 2020 at 4:02 PM Qian Cai <cai@redhat.com> wrote:
> > On Wed, 2020-10-07 at 16:08 -0400, Qian Cai wrote:
> > > Running some fuzzing by a unprivileged user on virtiofs could trigger the
> > > warning below. The warning was introduced not long ago by the commit
> > > c146024ec44c ("fuse: fix warning in tree_insert() and clean up writepage
> > > insertion").
> > > 
> > > From the logs, the last piece of the fuzzing code is:
> > > 
> > > fgetxattr(fd=426, name=0x7f39a69af000, value=0x7f39a8abf000, size=1)
> > 
> > I can still reproduce it on today's linux-next. Any idea on how to debug it
> > further?
> 
> Can you please try the attached patch?

It has survived the testing over the weekend. There is a issue that virtiofsd
hung, but it looks like a separate issue.

