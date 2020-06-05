Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880DA1EF68E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFELk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:40:59 -0400
Received: from mout.web.de ([212.227.15.4]:35773 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgFELk7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591357238;
        bh=XBmfME6bk2/kIuiLf4oVhHfs+WoanssvLRJfllkxFWE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RizNZuDYr41w5UEtEtQcXHbh9XNK9PGo7SCkYe6yyBUJfGLKlS1Sx+VSTTNSWL/8r
         TUKKqs0aBt5O5pfrhZ+OfFP5V84hrIJBbnfkkmMOZHXhrDoJAzDl19GgjSo6EoD1Uf
         KgqE4dyDkJFdc53BQlDEcyFzAZTMebsxYumtk/yg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK52w-1jNydU1zxO-00LS4O; Fri, 05
 Jun 2020 13:40:38 +0200
Subject: Re: block: Fix use-after-free in blkdev_get()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam> <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111039.GL22511@kadam>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
Date:   Fri, 5 Jun 2020 13:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605111039.GL22511@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WEGDoWRip9jL/sgr/pE0IMJKagkdEnECCzvGdwB8cDVw9OMPMsA
 NCsYc6o30soLo7fxSzI8tqYmVWwDGyEvbgDlsmOd0Ybwyq7iHXe/NE9FdLK1LLqEeighq7X
 r6EsEHLmkXMAOXPvFwfnk3k1F+y7IJOrHvc8i0c7WNq+Lt4o2RmmkB17jcEyisYAydFNZj8
 mP6a6AojO6qNlHQ4eE1YQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZxVPY6Wc7lw=:wEttNtoD8xuGrYxH6IKsad
 Uol9YdwKmYycGaDwYAnBENgCSufoRZ4tn1+Jv1OBOsFYDPESp26bgo7/URFToNPDvekDgE4SW
 0Kh8mpSUOTULCDJh5VHs+R8j0nbv4cV4J6q1BDEIsuPOt8jKe13paOxQzPg42v7/dgvyYsqsE
 +68kryxCNPJexpo5QKZdfr4J/xYqL0C3lMvtikc+2DGD7njvSnkxq3iJyBguoWwW3wyYpRShd
 EeWpSochuiqwyRIAw/+7RB2cszwW2kIKP9LLXhdFgvOnL4279vujkCFqT1flG338ikCDi8vXI
 ni4LiFW2N7NZDRo2W5dLWeCQYBsAI3nmhPV0fh0kFg+xgtYriE1VaDMX1XagdTZvVxUShHU/U
 KvDJrIApIBIC6+E0d7FVt4NNwLEHf3b/M5nO/IzGQX8ZU5ZO3UXKNLA3RtKNQmzH5Avr78+v9
 oO3AJKHtE1lk4KUxUZ+vbDEtEyKu6TXIfSRiueyuTUd1Ax+eBZLHAVdGl6BwFx/PEr8mhJ3mk
 OJOroxJ0XWn8mboFiPbYeDYzihqML4PesuP2NbfloM6JSXNilGmolrfDi4heX7QOPHveL0mcv
 w9STOQwXFT/Bwzg51jmR1uPANwG9QDBgNQxFqGT+IK6fP8Df8cVRiHKtznSPZznAtHHULBGj+
 4xSCZgnpprs0Ea7+IffMQH5b8yZzNSTKio7pZlL/jCOLEeNhhpHr75eWpXpZRQ3PvGaQp7nEN
 dMJaSw4m/hSFBAlnjY9chYrYPgofJ4zjsYyeb64mZM4kgQuH6E5aizQlX4ajJ7KdQ6ZNeGzyH
 abqRWxaD9u4hjFiOBPMw30u0nibPuZUdBHtS9/sZrrQ7mKXKN1r5MS91/EP6WMh4EUlWgFtDX
 PFPfPaWXvLjLZSZX0MY5ZrRJ6pyZsc3+oVGf8Y3q9yptNkVhhkHxotraCpXMQNxZ9vw4BVpZd
 Fq84oyOr3ArXGd6sQBwMhJOO4VEMy4oibQy9EgFwHB9za8YO6eePRVBBhhNWUWn36ufv9ao4y
 hMCIhomSJBMsfqo9OwlgPXZ/Udm+E3iF8xIqPtP5wExerG6awsPvOoSga4l2BIUgC1M+xdHvy
 0RrUwr79X6Uyntl4c3iDHtHGNnirlYOgeFy9WUNArGYCKgSJhADzkpncYkAvWR830mX0PiEsv
 JcWKl5a2S8/TtBI8CSJpsAwfCgDW3/BpsS7GyeYpjVy/71lzogoOgsaC/U7OIXdNGcVuvdVZ6
 UT5M8MqP/7Td9qb7w
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I am trying to contribute a bit of patch review as usual.
>
> We have asked you again and again to stop commenting on commit messages.

I am going to continue with constructive feedback at some places.


> New kernel developers have emailed me privately to say that your review
> comments confused and discouraged them.

Did these contributors not dare to ask me directly about mentioned details=
?

Some developers found parts of my reviews helpful, didn't they?

Regards,
Markus
