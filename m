Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D775700E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGQWxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 18:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjGQWwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1B137
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689634329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wy84DSSq8n2YYiK0mWellsvoswCFp/2kMAmdZ+UHHc=;
        b=WSU35uqKWX5qXsL9Eqi4qqS9SCAvtRdUoP1pqlX2O/1cZK2gLwhVZqB5eExNH9bGJCaIvz
        BDObKB9Pjgy9nnNWI0Mg64rgQFu1m48ni/wL21sFRtdMbxZw6ZsGTbH7RccOeY6fV1KDLB
        hn5FNoggx6POG5Pi2hj0zNHisqxMXTQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-HNpotWTgM-mzUYz3z84L2Q-1; Mon, 17 Jul 2023 18:52:07 -0400
X-MC-Unique: HNpotWTgM-mzUYz3z84L2Q-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-34611cc7b18so34900445ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 15:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689634327; x=1692226327;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wy84DSSq8n2YYiK0mWellsvoswCFp/2kMAmdZ+UHHc=;
        b=geEj3486FMA+XlDNiEvqqGIV6VG0RfmuiX2A9j7RDNiPb078jf4oq1J0lK53+cILuZ
         W5IsPE4Ys5X3vmqrJmVKaA+CWuAKfyGdrrFi8adrWf7QZcrWW7hLm0AswWY9QGRuS3bH
         +TZ8B7F0H3lAcsAf13q1dXjVBUx1aa3aoKZuiOX4toDQ3p+LtycU4conXbTiR/U1sf7G
         6scqx/S/AcCnH9ikQsEu1LZLiGEY6c+oiHfzarlBgSrXhPu0SaZ8YXaHAZVq83sVotRh
         qbR9XDiE+uVvm6QP6XqVZ06rj00MBY0bI01/VhlQSKBMBcYh/D/fVe0FC8SjOQ/7gMBi
         WK7Q==
X-Gm-Message-State: ABy/qLYHpTFzyMBSDp9WOMxlc9vme712igxqCDOJe2m0yPy5YMxSr1Xy
        4AJ6H56vxoiozYVKLrcWhIn7a81TbBohqNbBtVVA77laSoNAYT5O6GkoVIFot1HWcIkALAWwZHh
        J7nOs2DHZiUkwwCeQiermZ84Rsg==
X-Received: by 2002:a92:c651:0:b0:347:693a:7300 with SMTP id 17-20020a92c651000000b00347693a7300mr1012028ill.26.1689634327047;
        Mon, 17 Jul 2023 15:52:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlBYmCdY1EaUds5QDcX7E6PqePOm9wJTOwk2wgOBkeJp+9wxIVvWJlHjSTuTXhWw/m+atXtQ==
X-Received: by 2002:a92:c651:0:b0:347:693a:7300 with SMTP id 17-20020a92c651000000b00347693a7300mr1012015ill.26.1689634326829;
        Mon, 17 Jul 2023 15:52:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d10-20020a92ddca000000b00341c0710169sm242627ilr.46.2023.07.17.15.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:52:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 16:52:03 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Grzegorz Jaszczyk <jaz@semihalf.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-usb@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Fei Li <fei1.li@intel.com>, x86@kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Halil Pasic <pasic@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-fpga@vger.kernel.org, Zhi Wang <zhi.a.wang@intel.com>,
        Wu Hao <hao.wu@intel.com>, Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linuxppc-dev@lists.ozlabs.org, Eric Auger <eric.auger@redhat.com>,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, cgroups@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        intel-gvt-dev@lists.freedesktop.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Benjamin LaHaise <bcrl@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Moritz Fischer <mdf@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Dominik Behr <dbehr@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <20230717165203.4ee6b1e6.alex.williamson@redhat.com>
In-Reply-To: <ZLW8wEzkhBxd0O0L@ziepe.ca>
References: <20230630155936.3015595-1-jaz@semihalf.com>
        <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
        <CAH76GKPF4BjJLrzLBW8k12ATaAGADeMYc2NQ9+j0KgRa0pomUw@mail.gmail.com>
        <20230717130831.0f18381a.alex.williamson@redhat.com>
        <ZLW8wEzkhBxd0O0L@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Jul 2023 19:12:16 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Jul 17, 2023 at 01:08:31PM -0600, Alex Williamson wrote:
> 
> > What would that mechanism be?  We've been iterating on getting the
> > serialization and buffering correct, but I don't know of another means
> > that combines the notification with a value, so we'd likely end up with
> > an eventfd only for notification and a separate ring buffer for
> > notification values.  
> 
> All FDs do this. You just have to make a FD with custom
> file_operations that does what this wants. The uAPI shouldn't be able
> to tell if the FD is backing it with an eventfd or otherwise. Have the
> kernel return the FD instead of accepting it. Follow the basic design
> of eg mlx5vf_save_fops

Sure, userspace could poll on any fd and read a value from it, but at
that point we're essentially duplicating a lot of what eventfd provides
for a minor(?) semantic difference over how the counter value is
interpreted.  Using an actual eventfd allows the ACPI notification to
work as just another interrupt index within the existing vfio IRQ uAPI.
Thanks,

Alex

