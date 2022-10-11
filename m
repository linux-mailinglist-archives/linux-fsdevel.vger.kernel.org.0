Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D054B5FBD3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJKV5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 17:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKV5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:57:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51A474D8;
        Tue, 11 Oct 2022 14:57:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2152254pjq.1;
        Tue, 11 Oct 2022 14:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+F5sfh0Rem2dK5Aa0qmcHnEwuB0gA3U54snqr1MK29I=;
        b=eMRmp4cYWbPP6wDBMDfsmqZB8j3L0pdXz0USSKHbljqyKpkTzQECMDjMkmaEL5BbqD
         d0ojSuFCVN5LlYWi0iCcIJaPY9E22F8FbUSe6/FoWxLtoz0TZHq1OdLDUdOPQbV8BvXk
         IYqRrFJma0+WM09dFSflg7yM4Z8l8TqWlW5xa0/IeAklzdX6mmhsd3dwi7LV+XmH43O8
         WC/qUmZ2dauCdU4WSWsQWLlcVg/xCw9Qya4aUT3epUd2zQf8HDKjHwQWyBz++/rs0WXv
         MHUT0whOHvLxWtnvQ1n3OrLpFOtuz5e/qhDbh8/hhJxx/XFcgt6xR53Zw28rYZrRAnB5
         09xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F5sfh0Rem2dK5Aa0qmcHnEwuB0gA3U54snqr1MK29I=;
        b=s8Nlsou5wHF50evLjitEBZOomwTvpgXjf9kzL4eYByGdEp2ro8J55liEMAfjem+/m2
         D1oK02blGJj4gC8YmRFdWf3JD6quNgX6k40xvAXGhbGTFx8u7PnmZYgmAdosFY94w9uN
         6e9Z2+DAMCD7rj80BPcW6JA2+LBH42CHG6/yXcKwJTvhCdZJDPpjZYvAeHd1rIRFdQy+
         g7Wv7j+wdDAvoryI07Coob50vAublILdGJN7hgMh5hV5sh8UBoovA5gABdCQui+r8aRD
         LLaf1FdlY1TPkv0ofTBtSybyN05QDdlmB5fY3UpRCaTVNbnhPVZ+Pl5GIRMMUMOdZrT/
         Ywng==
X-Gm-Message-State: ACrzQf3eJtaxeGiNmIB1EXxY2DYpmX1K4bUDtKOidUNlGvhjIHaatq/A
        D9R65iAYc9jKxqPuDXE5Yjo=
X-Google-Smtp-Source: AMsMyM5fnG3YqCag8hs7pwcz+qWz/Zz7bczdTMGFDfgYvFKM/b6ZOo7yErr5yJz5nx1ogvRCHmpYNQ==
X-Received: by 2002:a17:902:ecc5:b0:180:a7ff:9954 with SMTP id a5-20020a170902ecc500b00180a7ff9954mr21822581plh.97.1665525429085;
        Tue, 11 Oct 2022 14:57:09 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z17-20020a170903019100b0018123556931sm6580371plg.204.2022.10.11.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:57:08 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/4] Rework find_get_entries() and find_lock_entries()
Date:   Tue, 11 Oct 2022 14:56:30 -0700
Message-Id: <20221011215634.478330-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Originally the callers of find_get_entries() and find_lock_entries()
were keeping track of the start index themselves as
they traverse the search range range.

This resulted in hacky code such as in shmem_undo_range():

			index = folio->index + folio_nr_pages(folio) - 1;

where the - 1 is only present to stay in the right spot after
incrementing index later. This sort of calculation was also being done
on every folio despite not even using index later within that function.

The first two patches change find_get_entries() and find_lock_entries()
to calculate the new index instead of leaving it to the callers so we can
avoid all these complications.

Furthermore, the indices array is almost exclusively used for the
calculations of index mentioned above. Now that those calculations are
no longer occuring, the indices array serves no purpose aside from
tracking the xarray index of a folio which is also no longer needed. 
Each folio already keeps track of its index and can be accessed using
folio->index instead.

The last 2 patches remove the indices arrays from the calling functions:
truncate_inode_pages_range(), invalidate_inode_pages2_range(),
invalidate_mapping_pagevec(), and shmem_undo_range(). 

Vishal Moola (Oracle) (4):
  filemap: find_lock_entries() now updates start offset
  filemap: find_get_entries() now updates start offset
  truncate: Remove indices argument from
    truncate_folio_batch_exceptionals()
  filemap: Remove indices argument from find_lock_entries() and
    find_get_entries()

 mm/filemap.c  | 40 ++++++++++++++++++++++++++++-----------
 mm/internal.h |  8 ++++----
 mm/shmem.c    | 23 +++++++----------------
 mm/truncate.c | 52 +++++++++++++++++++--------------------------------
 4 files changed, 59 insertions(+), 64 deletions(-)

-- 
2.36.1

