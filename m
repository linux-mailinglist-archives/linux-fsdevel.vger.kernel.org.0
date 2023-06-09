Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C5D728C38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjFIAKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFIAKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:10:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDF2D65
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:10:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b0424c5137so2736105ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686269416; x=1688861416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSknQxfSV4+v9bHiWDr5V1hQkXbY8spDyyTXR1H3Z7w=;
        b=HJx733T5tRUocMxkNFje8IYT5y67NY8WQ9amqlXIrQE0tO5LmkrYdPSVks/TY2IxcT
         UUj464UKm1Ze10y30+7mDcVysdd5foK6T1gZMus8II2PhCtKOmFDhUAG4if56wLq6NFn
         +ZvD8azh3PqqeTyEvmGfqWTkYtIV5V0p3FJcAivduTYIzAKAgH1q8iCTukjIcU5Ghiam
         9bgoebeFRtoeIrJgBTUVEsgoZxdqVfyknN9PGTnhCfK7BeWkP38a4H5SaLjXifwAErTq
         HBwvuRZNYSPNMd2LHZ3bmRQ1U5bP5bzkIRccEiGV60hLmbFPk36J+rSWZ0NVBxObvp5U
         J//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686269416; x=1688861416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSknQxfSV4+v9bHiWDr5V1hQkXbY8spDyyTXR1H3Z7w=;
        b=ROxAR2NkUMW0Lk+mBF19trxJ8QHHPweozhSjU1eQRZQ1KI6q7QAKhMkbx+A7qgHgLR
         NWe7zaPAUYW3vEiZM+GK2RMzaoJA3ykswdqEIkH+rrMsbkOENxoQKCNSndfuET1b9rIT
         Nzi+13b0pGFNVilXw2xMVSPRiiRolv7I4E/8RXGNTyoCfXfYy5iNTR2Onyw910HiajTG
         H6K1zVKWegAS6wS9UiosO3H9eavLO1HWGqglMT+Fj4JAbxYMlQE5gRJlVLzJK+GhSM1I
         zY1XWeFECrVRK5GL7YSm36AnpOi9F+n6OPKGgY1i0goohMHyqy3rqYeTjvvJbA1Y57jb
         G3pQ==
X-Gm-Message-State: AC+VfDxe84DFX6u8nU9E9Xc0vFJghiQ2qEPk8G15xot3O5fR3JYUl0o7
        gHbHuMKA9EWDYphF5W3hOywFoQ==
X-Google-Smtp-Source: ACHHUZ45Am6lEfPDHZXqbwBRcUTK946UynbP/40rwMJHewDfZDlg3Hu4zbYOxv8aShlKmaGa6Khcbw==
X-Received: by 2002:a17:903:120d:b0:1ad:f138:b2f6 with SMTP id l13-20020a170903120d00b001adf138b2f6mr10756391plh.16.1686269416027;
        Thu, 08 Jun 2023 17:10:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001ae8b4dc49bsm1972178plh.13.2023.06.08.17.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:10:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q7Phl-009U1b-0E;
        Fri, 09 Jun 2023 10:10:13 +1000
Date:   Fri, 9 Jun 2023 10:10:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joe Thornber <thornber@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, dm-devel@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZIJt5V2aO15yVt3B@dread.disaster.area>
References: <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <yq1sfb21zsa.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1sfb21zsa.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:03:40PM -0400, Martin K. Petersen wrote:
> 
> Dave,
> 
> > Possibly unintentionally, I didn't call it REQ_OP_PROVISION but that's
> > what I intended - the operation does not contain data at all. It's an
> > operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it contains a
> > range of sectors that need to be provisioned (or discarded), and
> > nothing else.
> 
> Yep. That's also how SCSI defines it. The act of provisioning a block
> range is done through an UNMAP command using a special flag. All it does
> is pin down those LBAs so future writes to them won't result in ENOSPC.

*nod*

That I knew, and it's one of the reasons I'd like the filesystem <->
block layer provisioning model to head in this direction. i.e. we
don't have to do anything special to enable routing of provisioning
requests to hardware and/or remote block storage devices (e.g.
ceph-rbd, nbd, etc). Hence "external" devices can provide the same
guarantees as a native software-only block device implementations
like dm-thinp can provide and everything gets just that little bit
better behaved...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
