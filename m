Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0967D83A85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfHFUnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 16:43:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37069 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfHFUnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 16:43:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so62221600lfh.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VR5feK3MwIDa28M66pr8cZaax0HRBgUIy/YXtAlUVAg=;
        b=Jcbiz/rlCveea1uGbs0To2AG2Fqr3qcVJByaj30biSJ6IGaZQU269n7UhHiJIq60zt
         F6m/iDUTKUaAxcfbj3aNcS1UVKWh0iBATpSeFcB2HZZd4zuUH74H+0AsiAw/3vHblfhG
         rGmoqX4hHVQvNh1Mo2WC3G6d946cIGSfRxOUfOJyomX+NAcaChMCm9wTSq80UpIDDyVy
         Wsy0W1UJUtub0zWt+iqZy9h9oHmBFsihiepiuxbUw6MWvMUQg0sLWv0bFV1e+nhfBD57
         VYDaUrEm2FkddHey3B0zSP911OVgsWvOlf8N8vWL7OUIPVuLGhouTH4qcL5ZHCc7EUMj
         /u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VR5feK3MwIDa28M66pr8cZaax0HRBgUIy/YXtAlUVAg=;
        b=pNkReJFnXbxt+ADJTVv+k/N41u7TMra1NkU+PdwhJhbQ3CrktXyZtXsKqN3fXm4aZT
         LJ3WmH9cTAlsr75o9oMmcPT1GrvBBaaX1FaWCRBhM+XWhz7Uabv3jjFgoNJ+lb5ybixq
         BAmofm/fmmvePKzfiArngYmt46Mblb/ISj4SUXrjAuVcczgmCl+2n8ogEo0ullZx+7Mo
         1PSXglIZ6GyDks2L68gqexoSc+Z5/5aSa+NOcku6321qaRU5LIwHM6qZjyodt6WWzvZP
         7FTwVJ+46lONNPGR3G7sZa0LHwHlKDdJNDQ5j8vj0jVRZnqGPYQgFfVY20X9FjorfrIT
         nIYw==
X-Gm-Message-State: APjAAAWAi0oTJHp1hW/yzh8eY/fb0fizAFOtcCXrpY2LXRXOWAZoG3/h
        dep5uhMQUSYqQhnM3/MJjYGGAdKgbDUPWiVgWWLPbA==
X-Google-Smtp-Source: APXvYqzWZs8IRpgox1WFTKnJpGnBDG26DorCdtZJQD2tgXVD7zBJA6DxGWkpIBTAdKDEhuxqp2JLjofjJIxta57O938=
X-Received: by 2002:a19:6f4b:: with SMTP id n11mr3649844lfk.163.1565124219457;
 Tue, 06 Aug 2019 13:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190805162521.90882-1-ebiggers@kernel.org> <20190805162521.90882-13-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-13-ebiggers@kernel.org>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Tue, 6 Aug 2019 13:43:27 -0700
Message-ID: <CA+_SqcBkR_8Z9EUTpK-dEW4PN+9P5OgJnqYDHtOhG+P1LjotPA@mail.gmail.com>
Subject: Re: [PATCH v8 12/20] fscrypt: add an HKDF-SHA512 implementation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 5 Aug 2019 at 09:28, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add an implementation of HKDF (RFC 5869) to fscrypt, for the purpose of
> deriving additional key material from the fscrypt master keys for v2
> encryption policies.  HKDF is a key derivation function built on top of
> HMAC.  We choose SHA-512 for the underlying unkeyed hash, and use an
> "hmac(sha512)" transform allocated from the crypto API.
>
> We'll be using this to replace the AES-ECB based KDF currently used to
> derive the per-file encryption keys.  While the AES-ECB based KDF is
> believed to meet the original security requirements, it is nonstandard
> and has problems that don't exist in modern KDFs such as HKDF:
>
> 1. It's reversible.  Given a derived key and nonce, an attacker can
>    easily compute the master key.  This is okay if the master key and
>    derived keys are equally hard to compromise, but now we'd like to be
>    more robust against threats such as a derived key being compromised
>    through a timing attack, or a derived key for an in-use file being
>    compromised after the master key has already been removed.
>
> 2. It doesn't evenly distribute the entropy from the master key; each 16
>    input bytes only affects the corresponding 16 output bytes.
>
> 3. It isn't easily extensible to deriving other values or keys, such as
>    a public hash for securely identifying the key, or per-mode keys.
>    Per-mode keys will be immediately useful for Adiantum encryption, for
>    which fscrypt currently uses the master key directly, introducing
>    unnecessary usage constraints.  Per-mode keys will also be useful for
>    hardware inline encryption, which is currently being worked on.
>
> HKDF solves all the above problems.
>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Paul Crowley <paulcrowley@google.com>
