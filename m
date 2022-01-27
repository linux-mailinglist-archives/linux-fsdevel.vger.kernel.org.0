Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2449E885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiA0RLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 12:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244354AbiA0RLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hISkPgWXBvxaPJR1A6cjvL239jVaZB/M99kE10NpdT4=;
        b=T+O7ZF/7JwGOGUIvTZg6eaQYi/o72n7QCPHbJSfgPmX6HDEXWnmZUPSVEdm8lDarNlmoJQ
        GhtzkmbItddRzZOso6KBieqZ7OBdv9/4kj0uaa5kTqtOwbux3JqkjCuyDbpdZkqKk5FAVM
        VrNTQbAElD3bR/3I/u1QNS555vRbMQw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-fLccZzKcMWm-_flZTN17qw-1; Thu, 27 Jan 2022 12:11:08 -0500
X-MC-Unique: fLccZzKcMWm-_flZTN17qw-1
Received: by mail-qv1-f70.google.com with SMTP id hu4-20020a056214234400b0041ad4e40960so3741111qvb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 09:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hISkPgWXBvxaPJR1A6cjvL239jVaZB/M99kE10NpdT4=;
        b=4PH8drAq6YZENTPgcOej0Wsj5CRCQcl3zDG3eV0u2Wt9Xxqhi6kpcp8nRg9WbIKNbr
         n9IoPp1OMvG0R731JJqAEMvs5Y/GjML00eKYpI+LOjHmg5UkMg3U3zG3HnbPOwHpThYq
         VavZj8Cl5dtpWfM2fdX28zJGylwpYTsON3xJvR9HwlNjQjiu/QIzNwc3PaPZZLhWi/bw
         XeTd4547D/uDXdbJWLzBM8FiqHClW1LDsJVCAP5L7o82/vtT3XIh2izQhwonsw39SK5W
         q7TiFQ9CD0ikWvHGz44nn4rLOCrNe/DbWXQVZM9sN1W2pnfq5ut+VeBFVvbIiaRJJhIY
         U7AA==
X-Gm-Message-State: AOAM5307I4L3pDm+Bio2eiwOpkwOP6OnMa0VwxQ7Yw9kDNH8qiY5jdmp
        UvrCp2/hbuBiQADJc2+ARU7xvLKm9v5YNfDN1cxHlenlIXHD9L4nOIJVLNprNaKBhe7vLEh8Bmg
        uk/pwKeCxJBUlWJRuh4KKl0Uq
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr4419658qvd.42.1643303467585;
        Thu, 27 Jan 2022 09:11:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQanMj7Y00ur/yzuLmY8gwfKPDXJeoixdwOU4KzNAVApl7lAtazZ8/rD9LIFjZrTulwd1nlg==
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr4419637qvd.42.1643303467335;
        Thu, 27 Jan 2022 09:11:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h6sm1661870qtx.43.2022.01.27.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:11:06 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:11:06 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 07/19] dm-snap: use blkdev_issue_flush instead of open
 coding it
Message-ID: <YfLSKlF89y3Cbf+S@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Use blkdev_issue_flush, which uses an on-stack bio instead of an
> opencoded version with a bio embedded into struct dm_snapshot.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

