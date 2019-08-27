Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B69F078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfH0QlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 12:41:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52634 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727401AbfH0QlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:41:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7RGeCWG021084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 12:40:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 70A4F42049E; Tue, 27 Aug 2019 12:40:12 -0400 (EDT)
Date:   Tue, 27 Aug 2019 12:40:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "boojin.kim" <boojin.kim@samsung.com>
Cc:     "'Satya Tangirala'" <satyat@google.com>,
        "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        "'Chao Yu'" <chao@kernel.org>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>, dm-devel@redhat.com,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] block: support diskcipher
Message-ID: <20190827164012.GN28066@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "boojin.kim" <boojin.kim@samsung.com>,
        'Satya Tangirala' <satyat@google.com>,
        'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Eric Biggers' <ebiggers@kernel.org>, 'Chao Yu' <chao@kernel.org>,
        'Jaegeuk Kim' <jaegeuk@kernel.org>,
        'Andreas Dilger' <adilger.kernel@dilger.ca>, dm-devel@redhat.com,
        'Mike Snitzer' <snitzer@redhat.com>,
        'Alasdair Kergon' <agk@redhat.com>, 'Jens Axboe' <axboe@kernel.dk>,
        'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Kukjin Kim' <kgene@kernel.org>,
        'Jaehoon Chung' <jh80.chung@samsung.com>,
        'Ulf Hansson' <ulf.hansson@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <CGME20190827083334epcas2p115d479190b9a72c886f66569add78203@epcas2p1.samsung.com>
 <03b201d55cb2$1d4d31b0$57e79510$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b201d55cb2$1d4d31b0$57e79510$@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:33:33PM +0900, boojin.kim wrote:
> 
> Dear Satya.
> Keyslot manager is a good solution for ICE. And probably no issue for FMP.
> But, I think it's complicated for FMP because FMP doesn't need
> any keyslot control.

Hi Boojin,

I think the important thing to realize here is that there are a large
number of hardware devices for which the keyslot manager *is* needed.
And from the upstream kernel's perspective, supporting two different
schemes for supporting the inline encryption feature is more
complexity than just supporting one which is general enough to support
a wider variety of hardware devices.

If you want somethig which is only good for the hardware platform you
are charged to support, that's fine if it's only going to be in a
Samsung-specific kernel.  But if your goal is to get something that
works upstream, especially if it requires changes in core layers of
the kernel, it's important that it's general enough to support most,
if not all, if the hardware devices in the industry.

Regards,

					- Ted
