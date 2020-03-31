Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C20199EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgCaTXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 15:23:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727852AbgCaTXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585682590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/e6nQfwC87/bpSm3h+1zpH7ZWFpAx96l++8B4RdaGPs=;
        b=cXpjS+P0pO6xcd8532sVJ5VBzaOKbeoTYw0c0OKzaLHRFq/z7n/Bin5PcL/bV7K4E8+ah2
        z3CrJ05y7AvM2fu++yvVSjvVIpcCBAYoThiMCP+kAf7gOYp+QNic9gWQe4l7oLqOvcIQ1a
        Zi9DKJ6h8esx7SUJ7Sg+9iOMSRNyfPU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-strx1RaANheVWHfQqB6HcQ-1; Tue, 31 Mar 2020 15:22:58 -0400
X-MC-Unique: strx1RaANheVWHfQqB6HcQ-1
Received: by mail-wr1-f69.google.com with SMTP id r15so5572000wrm.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 12:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/e6nQfwC87/bpSm3h+1zpH7ZWFpAx96l++8B4RdaGPs=;
        b=bEeJaf1j3pNjb0JjopVAqR/rbQQmCvzcdJDnmuQuJa0IyWqF+k6kijFosMzdjtdvmB
         4EvMnb7sYRFUImUfZdJBk+nQTBdCQnvtfxd5mRJJrLCB5v0YbW+YYgTdBfWgzGVMZ9is
         4VT1Q83EjlNqkjTApe4y6TWQSce26jGRkcJRTM59cbT6Vyh2N1ku1e3MZZZ5Pl51oia1
         h/H3Fzyfy8BsU+rw8NCO2ve8ibP4ZrUiKvjZZ/WEan0mPREeHNwwac+9uiRH4hGD0z8V
         YzPQqKKE7w3HWT/b8rVwMadxGp2jLsbMS9CdWUVwbQZa+Mjv+4DkPXNT3xlincMB2YQd
         7tZg==
X-Gm-Message-State: AGi0Pua4lllcn9Yo8ngMZlCRDwJV0fBy57fiqWJhv3A3KbhdxyZDl86E
        Gs3keq4ccQx8EcI6MHRR1BDw28Cm9j5qqGvk+JP5eIwbxlbLvthiSq53nZAW+e+bf9VqOjkA7x4
        JC7tnwIfnV9hB1P1NUhKQmTFJsg==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr410461wmd.50.1585682577018;
        Tue, 31 Mar 2020 12:22:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypL6Aptv5lg4jzAxGBVMyYmTlEWQ5XMw3Zc2nN0PSD/j3eiBvj2Rc762TemaQntDs3cCx4+NfA==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr410435wmd.50.1585682576785;
        Tue, 31 Mar 2020 12:22:56 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v7sm25508548wrs.96.2020.03.31.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:22:56 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:22:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: mmotm 2020-03-30-18-46 uploaded (VDPA + vhost)
Message-ID: <20200331152106-mutt-send-email-mst@kernel.org>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <969cacf1-d420-223d-7cc7-5b1b2405ec2a@infradead.org>
 <20200331143437-mutt-send-email-mst@kernel.org>
 <9c03fee8-af1a-2035-b903-611a631094b0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c03fee8-af1a-2035-b903-611a631094b0@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:42:47AM -0700, Randy Dunlap wrote:
> On 3/31/20 11:37 AM, Michael S. Tsirkin wrote:
> > On Tue, Mar 31, 2020 at 11:27:54AM -0700, Randy Dunlap wrote:
> >> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
> >>> The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
> >>>
> >>>    http://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> mmotm-readme.txt says
> >>>
> >>> README for mm-of-the-moment:
> >>>
> >>> http://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> >>> more than once a week.
> >>>
> >>> You will need quilt to apply these patches to the latest Linus release (5.x
> >>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> >>> http://ozlabs.org/~akpm/mmotm/series
> >>>
> >>> The file broken-out.tar.gz contains two datestamp files: .DATE and
> >>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> >>> followed by the base kernel version against which this patch series is to
> >>> be applied.
> >>>
> >>> This tree is partially included in linux-next.  To see which patches are
> >>> included in linux-next, consult the `series' file.  Only the patches
> >>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> >>> linux-next.
> >>>
> >>>
> >>> A full copy of the full kernel tree with the linux-next and mmotm patches
> >>> already applied is available through git within an hour of the mmotm
> >>> release.  Individual mmotm releases are tagged.  The master branch always
> >>> points to the latest release, so it's constantly rebasing.
> >>>
> >>> 	https://github.com/hnaz/linux-mm
> >>
> >> on i386:
> >>
> >> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_init':
> >> vdpa.c:(.init.text+0x52): undefined reference to `__vdpa_register_driver'
> >> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_exit':
> >> vdpa.c:(.exit.text+0x14): undefined reference to `vdpa_unregister_driver'
> >>
> >>
> >>
> >> drivers/virtio/vdpa/ is not being built. (confusing!)
> >>
> >> CONFIG_VIRTIO=m
> >> # CONFIG_VIRTIO_MENU is not set
> >> CONFIG_VDPA=y
> > 
> > Hmm. OK. Can't figure it out. CONFIG_VDPA is set why isn't
> > drivers/virtio/vdpa/ built?
> > we have:
> > 
> 
> Ack.  Hopefully Yamada-san can tell us what is happening here.

OK I pushed a fix (moving the vdpa subsystem up a level) and pushed into
my tree, refs/heads/next .  Seems to build fine now, but I'd appreciate
it if you can give it a spin.

-- 
MST

