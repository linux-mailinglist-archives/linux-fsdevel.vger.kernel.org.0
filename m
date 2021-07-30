Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305CD3DB5D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhG3JWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhG3JWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:22:53 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61558C061765
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=Ra0WWAw2Mj04Kwea6QDf7V2yA8kUT9MQWp8iJQ0oOq4=; b=yk/BKiptXzwcu5t2UW89OelZ00
        2MKYnpTiWKKg/RHY3t6mULleDGcO0Md0x+iiumC/L3t+aH/pq6AZh9CltnyrVS0WIjdOxAo6BAb6N
        FanEWnqLivBPnhckhvaU200c2UDEoFNcIciQIgD++aC0ZgGaMNwQDNQCQdgX/D4K8E2GcXd5d7f3Z
        Y5huhTudGGjaeHjkkxkGPVx2v5ZItwMjx1q8jj8YkVC9+jKKQd3w/9zoveXLdDJcYcIPhUpUAw2tR
        qsSmsnVZ5QzrmPz2SR3gf3I2F5SYtYErgFIkQGwV1Eti8LiJ02MuL3ywfFpWdV5O9jPBp6HF291qY
        TqywTm3kR3DZ8jTwQwRLgt1Y6z7FZHmaU5T0lcWlgpsnOkPoVQRKXzuB7h9sntvOWOnKs5ptqXOkh
        rgbijKe/LFE35cBEE8dfnJHz4T/THeizzoPE8Lsih/q3daQkIg76xQsbDRlBFqhFUHxCWu668Xcsi
        TdcXJ5u6F6qas65UQhGmIvg3;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1m9Oj9-0000zY-G2; Fri, 30 Jul 2021 09:22:47 +0000
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>
From:   Ralph Boehme <slow@samba.org>
Subject: Allowed operations on O_PATH handles
Message-ID: <f183fb32-3f08-94f1-19b9-6fe2447b168c@samba.org>
Date:   Fri, 30 Jul 2021 11:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ktTldlZOh3DKWwAuj89PaOSLy5qM1zixJ"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ktTldlZOh3DKWwAuj89PaOSLy5qM1zixJ
Content-Type: multipart/mixed; boundary="DOiCnXSTtquJTSACIbdK8BGFqiwfcwdRF";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, Christoph Hellwig <hch@lst.de>
Message-ID: <f183fb32-3f08-94f1-19b9-6fe2447b168c@samba.org>
Subject: Allowed operations on O_PATH handles

--DOiCnXSTtquJTSACIbdK8BGFqiwfcwdRF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi!

A recent commit 44a3b87444058b2cb055092cdebc63858707bf66 allows=20
utimensat() to be called on O_PATH opened handles.

If utimensat() is allowed, why isn't fchmod()? What's the high level=20
rationale here that I'm missing? Why is this not documented in man openat=
=2E2?

 From man openat.2

   O_PATH (since Linux 2.6.39)

     Obtain a file descriptor that can be used for two purposes:
     to indicate a location in the filesystem tree and to perform
     operations that act purely at the file descriptor level. The
     file itself is not opened, and other file operations (e.g.,
     read(2),  write(2),   fchmod(2),   fchown(2),   fgetxattr(2),
     ioctl(2), mmap(2)) fail with the error EBADF.
     ...

My understanding of which operations are allowed on file handles opened=20
with O_PATH was that generally modifying operations would not be=20
allowed, but only read access to inode data.

Can someone please help me to make sense of this?

Thanks a lot!
-slow


--DOiCnXSTtquJTSACIbdK8BGFqiwfcwdRF--

--ktTldlZOh3DKWwAuj89PaOSLy5qM1zixJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmEDxOYFAwAAAAAACgkQqh6bcSY5nkZh
thAAj76yspm2DfFagl4E53VHGP5mV3ri1H3S4j5lxzqIuvs+pJFeHsSdT53zrkQVH+zdG/x3Mt6H
9mJhv06oysn5GzR5dIItP7pF3my+Kruep0xvwRVLNQeOMdMVDl16/0VwkXfrl3WsJEIAdWDHCZO1
3X1kZMM0I+e9w877g59tpLF/MTaULLx2uVcD2EVB4RUP3CnjfcKvReU1mglllVZpwqeOH/SJCyaA
sYYFmawIrc/IHXxblmVZdxkJx2hs3MhT+LeiVg8XOe0oA4P4CpQUeIaM1xCqfXeV2K24asb3TJa+
p6iKwZnCid7/rdAHv/wBmQZN7hPWev0jejhAFwIvVN3dvs2wZaRbyLX3NTqR9r93U7O1z5l0aaN5
dKUg5hhTbqSEFK2NoIhsapuKlRuCpMedwXS7GgqAwOaJ4YCaIdvdYJbt8YDH7wWYFq4d5nk28kHB
YDsr0uZw9mvnSA1jtgS8fZeSQLL2TKSil3BuGA/vswGJVavtEcltBcE2/VbKNBAJWglvkX1nyl36
M6zfizAE/pvvf9Ybl0oDMJo15UfR2Dl1zVdDDlFDNOa72jaR0k47U4m8AhYpQHRjwjaN1JgF3BK/
cH/9iK2+v1+oDs2XbEzd0Iqu4m24saELmv0VKyCo7Cnrr6yNd+Vz/ziU7LG+mWCIzFo4cEh9rMZx
vuM=
=FekX
-----END PGP SIGNATURE-----

--ktTldlZOh3DKWwAuj89PaOSLy5qM1zixJ--
