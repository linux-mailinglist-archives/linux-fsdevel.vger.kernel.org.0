Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97B1F15DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgFHJtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 05:49:01 -0400
Received: from mout.web.de ([212.227.17.11]:57125 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgFHJtA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591609711;
        bh=UhBiCaqphOFBsqidZEeg4p1ZwCwt6Ym07NneRfrn9Oc=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=jT8m11dTEEeH5QhiWWRLD6oa6ZwiX7g0uMKfDJx/jG5hsBIV9XW+go3Fl4SjN5XO/
         YjgfiNS5kz44B9dYjLKXf6wLGj33hwZXSYSrlvMrWb996s4nE7npd4MjH1LODbWBsO
         8uERkV7g+1t78IO8aYelceDcWCvOspfOoYeQOmZk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUWH-1jNfdK1x9x-00LEpo; Mon, 08
 Jun 2020 11:48:31 +0200
To:     Christoph Hellwig <hch@lst.de>, Jason Yan <yanaijie@huawei.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     hulkci@huawei.com, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1612c34d-cd28-b80c-7296-5e17276a6596@web.de>
Date:   Mon, 8 Jun 2020 11:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+MuEzlT+1aT+Ll+008LUVKbn2mDNk507K37ypy/kCpWohG9L9L
 M+RDYntpOkH+3xGeFGD5BVBYlPB2XD4v8Her+Ok8GkOfBUigzDBHjk5hrxOJjXxPurG2ih9
 GbAC3f4YtrUUyB/SXTEPU+eAA60uY7oJsT6KY3kN2lQzUiOnLgVy511gt2BOSoQbuTw5+12
 OPrZwwoKmrf663Z5ZNBHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vQ61dujnjZ4=:l8lJZipZHgM0kGa221lFkq
 8cVikUCsOCp3L7zMLhBF8149YrC0Z/o7s/l+QbuzHvAIcNV/yEeGpCMK5qYMl+0LD8tCd5YGa
 rnmHvoILzZBXXnRP6x11TfvrGOVyFl5qprSZASF3Uts9nAggQBof32wPyHI8WozLztMKAa5Er
 olL4+Fv98+2kzEwZtTI/HX+Jfdk65pB4St2AS5ECoEZCwhitqYebz9L3z54HLgKBS8EvJwNG4
 rS3wYYtY3tqMUKcalDfYY3aX+cHN4dFWMh1dIKO6K8p32cBMy7D7m3xfEBjYQLz2AnnyeTnF7
 sY2cvGQI5vS+SoGuTFu1cZlcoyo+3eTWfq++mfu4WZTEuE2Ljx0zE3DmbwJunvyrztqJTiPPx
 GFXOQDdidsFYmZ66TFTem9LPgablqasRG9meq9OIOtmDoJiXrTkAd2DrRhPC09//N8TzIkfla
 86pxA5W3DKJQD4IzQLSVXkYTkmNXMGmM94s36Oi8DK/9NCzFZqpGDMgvWFWbt1JANtg2WAnID
 QHzkSKPaemsoa1sbR8LbXYZdK+aqWUj1cU7AjHjUlf5AEuj6JSRkHT3DvZvfbJS1LKWUteEe7
 QKV6oFGw86Lh9jW22673BGVjel22I2OXe2+7W3EJmEDvMFkWjmMQe0zVoSYd4afUUgzOMEEwS
 DuqHlEdgJog15Ar1l9NQjUmZLhJH6O83/IQbBffoqYvad9v/D91c+o+pfY3/LfcSscjle4xj7
 aHkPiJATV42jAWO/SWdEZasn0NA0dQPnjsEMZgRy6CvX8cMtUQWVrxOvDoQri8ROezOBGsflW
 2FjahTChF4SAa+cN8nBEMJScWL/PhOKc2tZ3Ex5uNhu90akQ820eAz191r5c+lg4KK1Y8yDaI
 +dUTOotxlyAmbxVv6Idmb1y3Kk2COXxS9J6V1P6bMZztbasqYTJ0pZrx/d7ELJaHyP0b9ExUi
 iy5iA2LpRZZqoYeioUl7iNNN1o9q0+P4rHMSDkhoJgzTp1f1Ki2QCVUgLOvkjvYQMd02hqW8B
 YHbdMoLVl8SAVwxZo6CKD9ilBd1iUzke3EKWRUzWZRUEj139vc1b2R3cjH3iXSq9YhFbVrQME
 rR1kd4ucNJ/xNXsHDV6MH2oNvxN610dPHBXBwoEQ6yuQxvZO1owvXgUsiH3rlz6gcWDImFdjm
 y2wSNciO3iNghQjBiGd3qPJMEZWCLJi39rarnMNvEMpriHP8TapmBly/3QE4gCtb0TINRsNkK
 JiH9HGDqlnIb6Bvs7
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

How does this feedback fit to remaining typos in the change description?
Do you care for any further improvements of the commit message
besides the discussed tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
