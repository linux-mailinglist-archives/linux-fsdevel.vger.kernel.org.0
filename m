Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6512423E42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhJFM4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 08:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231259AbhJFM4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633524899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7EGx+I3Pcl/Qx0WL2hHgN+pODGh3Si8+GexZplFhi04=;
        b=YT+AuhgbehXAQVouF3fxT0BbaKO/e+EydaHgCkCcY/49gDzHB35UkHOZvTL9/f4fFvkSF1
        Bx2i0XJY/0zNQfFpFFMNSKlOAnJ83z5j135FXZlzLoJ0dV0V+TRhkCJm2TuinyIFxMrTLo
        oGcQKQ9Om0WS2zeWzlDoPtKSUIMMx+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-SZmBAHDAOcS23sfjdW1odA-1; Wed, 06 Oct 2021 08:54:57 -0400
X-MC-Unique: SZmBAHDAOcS23sfjdW1odA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7870107B27C;
        Wed,  6 Oct 2021 12:54:56 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98FBD1F42A;
        Wed,  6 Oct 2021 12:54:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1FA28220BDB; Wed,  6 Oct 2021 08:54:56 -0400 (EDT)
Date:   Wed, 6 Oct 2021 08:54:56 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 5/8] virtiofs: Add a virtqueue for notifications
Message-ID: <YV2coMOSQCVRry8v@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
 <20210930143850.1188628-6-vgoyal@redhat.com>
 <CAJfpeguTohOfd60+vkVMBOHEfcT4T5hTuWtE2pqCLStNTHuZFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguTohOfd60+vkVMBOHEfcT4T5hTuWtE2pqCLStNTHuZFQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:46:46PM +0200, Miklos Szeredi wrote:
> On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > @@ -34,10 +35,12 @@ static LIST_HEAD(virtio_fs_instances);
> >
> >  enum {
> >         VQ_TYPE_HIPRIO,
> > -       VQ_TYPE_REQUEST
> > +       VQ_TYPE_REQUEST,
> > +       VQ_TYPE_NOTIFY
> >  };
> >
> >  #define VQ_NAME_LEN    24
> > +#define VQ_NOTIFY_ELEMS 16     /* Number of notification elements */
> 
> Where does this number come from?

I just chose an arbitrary number. Not sure what's a good number and
how to decide that. Good thing is that its not part of the protocol
so guest should be able to change it if need be.

Stefan, do you have any thoughts on this depending on what other
virtio drivers have done w.r.t this.

Thanks
Vivek

