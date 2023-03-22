Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87896C51EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjCVRIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCVRIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:08:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C717A5F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 10:08:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cy23so75683773edb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679504885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ/qCKKtUwESl9xaaIjrhAfZQFyi97d2S+2qUwoE1zg=;
        b=BtQef+Hqn3ot8lwaQcEVM5C4lsh6H+ZHQlJ4aIK8TzuTf7FIvWKNTjsarQfXoMgVGz
         tes3fx1pwwIdSTCr6Qph5SoHMfuYGJyT/Rz4yyQrUNR6Azm7CjJUKmJ8xEo81D/DtcYq
         x53jOksMzJnFTdOzzfBbGg1B/o2W9aO6dc4Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ/qCKKtUwESl9xaaIjrhAfZQFyi97d2S+2qUwoE1zg=;
        b=OO/0+tbP3FRsmCkDZKezGonjqcyBuOXCLvDEUutR8BkzCrhFTRbaPlJJScQIZReU+x
         t10URmOeT8A4QRXbkV1F33MaqiqMaGzzarlaw6hi5KXo5pwoYoGOKFn6Dp3Alad0Myw8
         nxjzYFrUTeZ4bb/jbC+Ckpzzc6oHTiJj/5C9iVmzW+9/zxgnZ/+ezBGGIIpp/xctCX23
         mO/LvJLqR4/kHlZgfV2c8A4dMiMXAdjOlq18WEOVRw6CmyOrx8tYnFCEljdCXIQ0lTXq
         Oy9RrQ5lmhymblKVbqOpOk1PIkfKDsl3pwI+PnaBylAKXcyVLadCb+eYYscPyKyQeOrr
         fCzA==
X-Gm-Message-State: AO0yUKX0ttduPSd4EmpIp2DHgdJkuN1NlJ1WoB8EZ4cjmVb7zsAlrA72
        1WgxjhpqeIqWTAsxYO+rETKA+RG8tvcm4JQ8iyXkV74n
X-Google-Smtp-Source: AK7set+wia3A/YNs9kMD/axpG2R/7rHyLmXIp79TvjoTdi6pglCxmQSn6aLTHs6q6blJNJ6mHrRQmQ==
X-Received: by 2002:a17:906:1611:b0:91f:5845:4e3c with SMTP id m17-20020a170906161100b0091f58454e3cmr7465880ejd.42.1679504885202;
        Wed, 22 Mar 2023 10:08:05 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b008ec4333fd65sm7461811ejl.188.2023.03.22.10.08.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:08:03 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id o12so75770166edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 10:08:03 -0700 (PDT)
X-Received: by 2002:a17:906:344d:b0:933:7658:8b44 with SMTP id
 d13-20020a170906344d00b0093376588b44mr3561499ejb.15.1679504883222; Wed, 22
 Mar 2023 10:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein> <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
 <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
 <20230321201632.o2wiz5gk7cz36rn3@wittgenstein> <CAHk-=wg2nJ3Z8x-nDGi9iCJvDCgbhpN+qnZt6V1JPnHqxX2fhQ@mail.gmail.com>
 <20230322101710.6rziolp4sqooqfwq@wittgenstein>
In-Reply-To: <20230322101710.6rziolp4sqooqfwq@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Mar 2023 10:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+VuPWUtCa=s7jmkqjMOvGbn=Q-KT-8YXdOLxFAPKiPQ@mail.gmail.com>
Message-ID: <CAHk-=wh+VuPWUtCa=s7jmkqjMOvGbn=Q-KT-8YXdOLxFAPKiPQ@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:17=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I don't feel strongly about this either and your points are valid. So I
> incorporated that and updated the comments in the code. In case you'd lik=
e to
> take another look I've now put this up at:

Ack, LGTM.

               Linus
